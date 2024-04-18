resource "aws_vpc" "dev" {
  cidr_block = "10.10.0.0/24"

  tags = {
    Name = "${var.env_m}-vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = "10.10.0.0/24"

  tags = {
    Name = "10.10.0.0/24-${var.env_m}-subnet"
  }
}

resource "aws_vpc_peering_connection" "foo" {
  peer_vpc_id   = var.default-vpc-id_m
  vpc_id        = aws_vpc.dev.id
  auto_accept   = true

  tags = {
    Name = "dev-vpc to default-vpc"
  }
}

resource "aws_route" "dev-route" {
  route_table_id             = aws_vpc.dev.default_route_table_id
  vpc_peering_connection_id  = aws_vpc_peering_connection.foo.id
  destination_cidr_block     =  "172.31.0.0/16"
}

resource "aws_route" "default-route" {
  route_table_id             = "rtb-0d3e433084e76a929"
  vpc_peering_connection_id  = aws_vpc_peering_connection.foo.id
  destination_cidr_block     =  aws_vpc.dev.cidr_block
}
