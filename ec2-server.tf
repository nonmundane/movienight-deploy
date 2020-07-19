data "aws_ami" "ubuntu_lts_latest" {
  most_recent = true
  owners = ["099720109477"]
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "movienight" {
  name        = "movienight"
  description = "Allow SSH and streaming ports open"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH Access"
  }

  # Stream access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Public Streaming Port"
  }

  # RTMP access from anywhere
  ingress {
    from_port   = 1935
    to_port     = 1935
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "RTMP Inbound Port"
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_instance" "movienight" {
  ami                    = data.aws_ami.ubuntu_lts_latest.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.auth.id
  security_groups = ["${aws_security_group.movienight.name}"]
  # a1 instances are only in us-west-2a or 2c, subnet_id indexes start at 0 not 1
  #subnet_id = element(var.subnet, 0)

  connection {
    type        = "ssh"
    user        = var.ssh_username
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "10"
    delete_on_termination = true
  }

  provisioner "remote-exec" {
    inline = [
      "echo Waiting on cloud-init...; cloud-init status --wait",
      "echo Checking systemd...; while ! systemctl --quiet is-system-running; do echo Waiting on systemd...; sleep 1; done",
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get -y install gcc",
      "sudo apt-get -y install git",
      "sudo apt-get -y install build-essential",
      "sudo apt-get -y install golang-go",
      "sudo apt-get -y update",
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo git -C /opt clone https://github.com/zorchenhimer/MovieNight",
      "sudo make -C /opt/MovieNight/",
      "sudo cp /usr/share/go-1.12/misc/wasm/wasm_exec.js /opt/MovieNight/static/js/wasm_exec.js",
      "sudo chown -R ubuntu:ubuntu /opt/MovieNight",
    ]
  }

  provisioner "file" {
    source      = "movie_night.service"
    destination = "/tmp/movie_night.service"
  }

  provisioner "file" {
    source      = "download_emotes.sh"
    destination = "/tmp/download_emotes.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/download_emotes.sh",
      "sudo mv /tmp/download_emotes.sh /opt/download_emotes.sh",
      "sudo /opt/download_emotes.sh",
      "sudo mv /tmp/movie_night.service /etc/systemd/system/movie_night.service",
      "sudo systemctl enable movie_night",
      "sudo systemctl start movie_night",
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt install -y nginx",
      "sudo rm -f /etc/nginx/sites-enabled/default",
    ]
  }

  provisioner "file" {
    source      = "movie_night.conf"
    destination = "/tmp/movie_night.conf"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/movie_night.conf /etc/nginx/sites-available/movie_night.conf",
      "sudo ln -s /etc/nginx/sites-available/movie_night.conf /etc/nginx/sites-enabled/movie_night.conf",
      "sudo systemctl restart nginx",
    ]
  }
}

resource "aws_route53_record" "movienight" {
  zone_id = var.route53_domain_id
  name    = "mystream.${var.route53_domain}"
  type    = "A"
  ttl     = "300"
  records = ["${element(aws_instance.movienight.*.public_ip, 0)}"]
}
