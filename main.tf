provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {}
}

module "frontend" {
  source                      = "./modules/app"
  ami_m                       = var.ami
  instance_type_m             = "t2.micro"
  vpc_security_group_ids_m    = var.vpc_security_group_ids
  tags_m                      = var.tags["frontend"]
}

module "backend" {
  source                      = "./modules/app"
  ami_m                       = var.ami
  instance_type_m             = "t2.micro"
  vpc_security_group_ids_m    = var.vpc_security_group_ids
  tags_m                      = var.tags["backend"]
}

module "mysql" {
  source                      = "./modules/app"
  ami_m                       = "t3.small"
  instance_type_m             = var.instance_type
  vpc_security_group_ids_m    = var.vpc_security_group_ids
  tags_m                      = var.tags["mysql"]
}
