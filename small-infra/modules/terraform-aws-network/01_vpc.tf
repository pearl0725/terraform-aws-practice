locals {
  vpc_id = element(concat(aws_vpc.this.*.id), 0)
}

########################################
# VPC
########################################

resource "aws_vpc" "this" {
  count = var.create_vpc ? 1 : 0

  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    var.vpc_tags,
    {
      Name = format("%s", var.name)
    }
  )
}

