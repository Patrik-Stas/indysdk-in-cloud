variable "region" {
  default="eu-west-1"
}

variable "availability-zone" {
  default = "eu-west-1a"
}

variable "source-ami" {
  default = "ami-0c967febb1d86ffa4" // 64bit Ubuntu 16.04 in eu-west-1a region
}

variable "instance-type" {
  default = "t2.medium"
}

variable "keypair-name" {
  default = "name-of-your-keypair-in-aws"
}

variable "private-key-path" {
  default = "/path/to/your/ec2/private-key"
}


