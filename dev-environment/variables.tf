variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "x86_instance_type" {
  default = "t3.micro"
}

variable "arm_instance_type" {
  default = "t4g.small"
}

variable "db_username" {
  default = "devuser"
}

variable "db_password" {
  sensitive = true
}
