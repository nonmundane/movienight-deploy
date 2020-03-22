variable "route53_domain" {
  default = "nonmundane.org"
}

variable "route53_domain_id" {
  default = "Z3SYOSETE1AR5Y"
}

variable "aws_image" {
  # this is Ubuntu 19.10 for amd64
  default = "ami-041d04234b6826a27"
}

variable "aws_region" {
  default = "us-west-2"
}

variable "key_name" {
  default = "movienight"
}

variable "public_key" {
  default = "ssh-rsa XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX movienight"
}

variable "vpc_id" {
  default = "vpc-d7017dae"
}

variable "instance_type" {
  # this app needs network throughput, not CPU
  default = "t3a.small"
}

variable "subnet" {
  default = ["subnet-6d884826", "subnet-9257f1eb", "subnet-d96eed83"]
}

variable "ssh_username" {
  default = "ubuntu"
}

variable "stream_key" {
  default = "INSERT_YOUR_KEY_HERE_MAKE_IT_STRONG"
}
