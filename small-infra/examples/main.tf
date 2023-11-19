locals {
  name   = "prac"
  region = "ap-northeast-2"
  tags = {
    Owner       = "Doa Choi"
    Environment = "prod"
    Name        = "prac"
  }
}

########################################
# VPC Module
########################################

module "vpc" {
  source = "../modules/terraform-aws-network"

  vpc_cidr = "10.0.0.0/16"

  azs             = ["${local.region}a", "${local.region}c"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true
}

