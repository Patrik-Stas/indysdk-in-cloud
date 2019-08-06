variable "region" {
  default="eu-west-1"
}

variable "availability-zone" {
  default = "eu-west-1a"
}

variable "source-ami" {
  default = "<ami of what you have built in ec2-ubuntu-indysdk>"
}

variable "instance-type" {
  default = "t2.small"
}

variable "keypair-name" {
  default = "name-of-your-keypair-in-aws"
}

variable "private-key-path" {
  default = "/path/to/your/ec2/private-key"
}

variable "agency_name" {
  default = "dummy-cloud-agency"
}

variable "log_level_indy" {
  default = "warn"
}

variable "log_level_vcx" {
  default = "warn"
}

variable "log_level_dummy" {
  default = "info"
}

variable "ijprovision" {
  default = "v1.8.3.release"
}

variable "instance-name" {
  default = "terraformed-dummy-agency"
}