variable "aws_image" {
  # Ubuntu 19.10 amd64 us-west-2
  # default = "ami-041d04234b6826a27"
  # Ubuntu 19.10 arm64 us-west-2
  default = "ami-0e2b33aeed6565ce7"
}

variable "aws_region" {
  default = "us-west-2"
}

variable "instance_type" {
  # this app is network sensitive primarily, a t3.small or a1.medium should run it fine
  # default = "t3a.small"
  default = "a1.medium"
}

variable "vpc_id" {
  default = "vpc-d7017dae"
}

variable "subnet" {
  # we list the subnets available in our vpc in order of AZ (a,b,c)
  default = ["subnet-6d884826", "subnet-9257f1eb", "subnet-d96eed83"]
}

variable "key_name" {
  default = "movienight"
}

variable "ssh_username" {
  default = "ubuntu"
}

variable "public_key" {
  default = "ssh-rsa XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX movienight"
}

variable "route53_domain" {
  default = "nonmundane.org"
}

variable "route53_domain_id" {
  default = "Z3SYOSETE1AR5Y"
}
