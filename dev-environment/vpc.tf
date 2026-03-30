data "aws_availability_zones" "azs" {}

module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "~> 6.3.0"
  name            = "dev-vpc"

  cidr            = var.vpc_cidr_block
  azs             = [data.aws_availability_zones.azs.names[0]]
  public_subnets  = [var.public_subnet_cidr_block]
  private_subnets = [var.private_subnet_cidr_block]

  enable_dns_hostnames   = true
  enable_dns_support     = true  
  
  enable_nat_gateway     = false
}
