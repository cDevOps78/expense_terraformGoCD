resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc_cidr_block_m

  tags = {
    Name = "${var.env_m}-vpc"
  }
}

resource "aws_subnet" "dev-subnet" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = var.subnet_cidr_block_m
  # map_public_ip_on_launch = true

  tags = {
    Name = "${var.env_m}-subnet1"
  }
}

resource "aws_vpc_peering_connection" "foo" {
  peer_vpc_id   = var.default_vpc_id_m
  vpc_id        = aws_vpc.dev-vpc.id
  auto_accept   = true

  tags = {
    Name = "VPC Peering between ${var.env_m}_vpc to default_vpc"
  }
}

resource "aws_route" "dev-vpc-route" {
  route_table_id              = aws_vpc.dev-vpc.default_route_table_id
  vpc_peering_connection_id   = aws_vpc_peering_connection.foo.id
  destination_cidr_block      = "172.31.0.0/16"
}

resource "aws_route" "default-vpc-route" {
  route_table_id            = "rtb-0d3e433084e76a929"
  vpc_peering_connection_id = aws_vpc_peering_connection.foo.id
  destination_cidr_block    = aws_vpc.dev-vpc.cidr_block
}