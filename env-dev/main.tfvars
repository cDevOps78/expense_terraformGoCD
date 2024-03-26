ami = "ami-05f020f5935e52dc4"
// instance_type = "t2.micro"
vpc_security_group_ids = ["sg-037dcd68553894e24"]
tags = {
  frontend = {
    Name    = "dev-frontend"
    monitor = "Yes"
    project = "expense-project"
  }
  backend = {
    Name    = "dev-backend"
    monitor = "Yes"
    project = "expense-project"
  }
  mysql = {
    Name    = "dev-mysql"
    monitor = "Yes"
    project = "expense-project"
  }
}


