resource "aws_vpc" "dev-vpc" {
  cidr_block = var.vpc_cidr_block_m

  tags = {
    Name = "${var.env_m}-vpc"
  }
}


resource "aws_subnet" "dev-subnet" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = var.subnet_cidr_block_m

  #map_public_ip_on_launch = true

  tags = {
    Name = "${var.env_m}-subnet1"
  }
}
