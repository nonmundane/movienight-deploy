provider "aws" {
  region  = var.aws_region
  profile = "default"
  version = "~> 2.0"
}
