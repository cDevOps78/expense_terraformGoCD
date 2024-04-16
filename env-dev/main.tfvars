ami = "ami-090252cbe067a9e58"
// instance_type = "t2.micro"
vpc_security_group_ids = ["sg-0a88820d7b4d3ff2a"]
tags = {
  frontend = {
    Name    = "dev-frontend"
  }
  backend = {
    Name    = "dev-backend"
  }
  mysql = {
    Name    = "dev-mysql"
  }
}

env = "dev"

# VPC

vpc_cidr_block="10.0.10.0/24"
subnet_cidr_block="10.0.10.0/24"


