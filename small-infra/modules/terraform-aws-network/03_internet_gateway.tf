########################################
# Internet Gateway
########################################

resource "aws_internet_gateway" "this" {
  count = var.create_vpc && var.create_igw && length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = local.vpc_id

  tags = merge(
    {
      Name = format("%s", var.name)
    }
  )

  depends_on = [
    aws_vpc.this
  ]
}

