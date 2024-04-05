ami = "ami-05f020f5935e52dc4"
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

