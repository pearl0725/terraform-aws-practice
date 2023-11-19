########################################
# Public routes
########################################

resource "aws_route_table" "public_rt" {
  count = var.create_vpc && length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = local.vpc_id

  tags = {
    Name = format("%s", var.name)
  }
}

resource "aws_route" "public_igw" {
  count = var.create_vpc && var.create_igw && length(var.public_subnets) > 0 ? 1 : 0

  route_table_id         = aws_route_table.public_rt[0].id
  destination_cidr_block = var.all_cidr
  gateway_id             = aws_internet_gateway.this[0].id

  timeouts {
    create = "5m"
  }
}

########################################
# Private routes
########################################

resource "aws_route_table" "private_rt" {
  count = var.create_vpc && length(var.private_subnets) > 0 ? 1 : 0

  vpc_id = local.vpc_id

  tags = merge(
    {
      Name = format("%s", var.name)
    }
  )
}

resource "aws_route" "private_nat" {
  count = var.create_vpc && var.enable_nat_gateway ? 1 : 0

  route_table_id         = aws_route_table.private_rt[count.index].id
  destination_cidr_block = var.all_cidr
  nat_gateway_id         = aws_nat_gateway.this[0].id

  timeouts {
    create = "5m"
  }
}

########################################
# Route table association
########################################

resource "aws_route_table_association" "public_rt" {
  count = var.create_vpc && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_rt[0].id
}

resource "aws_route_table_association" "private_rt" {
  count = var.create_vpc && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_rt[0].id
}


