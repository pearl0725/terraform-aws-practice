########################################
# NAT Gateway
########################################

resource "aws_eip" "this" {
  count = var.create_vpc && var.enable_nat_gateway ? 1 : 0

  tags = merge(
    {
      Name = format("%s", var.name)
    }
  )
}

# Single NAT
resource "aws_nat_gateway" "this" {
  count = var.create_vpc && var.enable_nat_gateway ? 1 : 0

  allocation_id = aws_eip.this[0].id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    {
      Name = format("%s", var.name)
    }
  )

  depends_on = [
    aws_internet_gateway.this
  ]
}

