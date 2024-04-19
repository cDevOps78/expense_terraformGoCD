resource "aws_vpc" "dev" {
  cidr_block = "10.10.0.0/24"

  tags = {
    Name = "${var.env_m}-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.dev.id

  tags = {
    Name = "${var.env_m}-vpc-igw"
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

resource "aws_route" "default-vpc-route" {
  route_table_id             = "rtb-0d3e433084e76a929"
  vpc_peering_connection_id  = aws_vpc_peering_connection.foo.id
  destination_cidr_block     =  aws_vpc.dev.cidr_block
}

resource "aws_subnet" "public-subnets" {
  count = length(var.public_subnets)

  vpc_id = aws_vpc.dev.id
  cidr_block = var.public_subnets[count.index]
  availability_zone = var.available_zone[count.index]

  tags = {
    Name = "${var.env_m}-public${count.index+1}-${var.available_zone[count.index]}-${var.public_subnets[count.index]}"
  }
}

resource "aws_route_table" "public-rt" {
  count = length(var.public_subnets)
  vpc_id = aws_vpc.dev.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.env_m}-public-rt${count.index+1}-${var.available_zone[count.index]}-${var.public_subnets[count.index]}"
  }
}

resource "aws_route_table_association" "public-rt-a" {
  count = length(var.public_subnets)
  subnet_id      = aws_subnet.public-subnets[count.index].id
  route_table_id = aws_route_table.public-rt[count.index].id
}







resource "aws_subnet" "frontend" {
  count = length(var.frontend_subnets)

  vpc_id = aws_vpc.dev.id
  cidr_block = var.frontend_subnets[count.index]
  availability_zone = var.available_zone[count.index]

  tags = {
    Name = "${var.env_m}-frontend${count.index+1}-${var.available_zone[count.index]}-${var.frontend_subnets[count.index]}"
  }
}

resource "aws_subnet" "backend" {
  count = length(var.backend_subnets)

  vpc_id = aws_vpc.dev.id
  cidr_block = var.backend_subnets[count.index]
  availability_zone = var.available_zone[count.index]

  tags = {
    Name = "${var.env_m}-backend${count.index+1}-${var.available_zone[count.index]}-${var.backend_subnets[count.index]}"
  }
}

resource "aws_subnet" "mysql" {
  count = length(var.mysql_subnets)

  vpc_id = aws_vpc.dev.id
  cidr_block = var.mysql_subnets[count.index]
  availability_zone = var.available_zone[count.index]

  tags = {
    Name = "${var.env_m}-mysql${count.index+1}-${var.available_zone[count.index]}-${var.mysql_subnets[count.index]}"
  }
}