########################################
# Public Subnet
########################################

resource "aws_subnet" "public" {
  count = var.create_vpc && length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  vpc_id            = local.vpc_id
  cidr_block        = element(concat(var.public_subnets, [""]), count.index) # prac-pri-ap-northeast-2x 형태로 구성되므로 변경 필요
  availability_zone = element(var.azs, count.index)

  map_public_ip_on_launch = var.map_public_ip_on_launch # True

  tags = merge(
    {
      Name = format("%s", var.name)
    }
  )

  depends_on = [
    aws_internet_gateway.this
  ]
}


########################################
# Private Subnet 
########################################

resource "aws_subnet" "private" {
  count = var.create_vpc && length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

  vpc_id            = local.vpc_id
  cidr_block        = element(concat(var.private_subnets, [""]), count.index)
  availability_zone = element(var.azs, count.index)

  tags = merge(
    {
      Name = format("%s", var.name)
    }
  )
}




