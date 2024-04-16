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