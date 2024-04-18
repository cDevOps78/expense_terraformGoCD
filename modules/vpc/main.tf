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