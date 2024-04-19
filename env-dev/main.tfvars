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

default-vpc-id = "vpc-0dfa2ee2180ae8e1a"

frontend_subnets = ["10.10.0.0/27","10.10.0.32/27"]
backend_subnets  = ["10.10.0.64/27","10.10.0.96/27"]
mysql_subnets  = ["10.10.0.128/27","10.10.0.160/27"]

available_zone = ["us-east-1a","us-east-1b"]

public_subnets  = ["10.10.0.192/27","10.10.0.224/27"]



