provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {}
}

#provider "vault" {
#   address = "https://vault-internal.azcart.online:8200"
#   skip_tls_verify = true
#}

#data "vault_kv_secret" "secret_data" {
#  path = "common/ssh"
#}

#data "vault_generic_secret" "rundeck_auth" {
#  path = "common/ssh"
#}
#
#resource "local_file" "vault" {
#  filename = "/tmp/common"
#  content = data.vault_generic_secret.rundeck_auth.data_json
#}
#
#data "vault_generic_secret" "duck" {
#  path = "common1/ssh1"
#}
#
#resource "local_file" "vault1" {
#  filename = "/tmp/common1"
#  content = data.vault_generic_secret.duck.data_json
#}




#
#module "frontend" {
#  depends_on = [module.backend]
#
#  source                      = "./modules/app"
#  ami_m                       = "ami-090252cbe067a9e58"
#  instance_type_m             = "t2.micro"
#  vpc_security_group_ids_m    = var.vpc_security_group_ids
#  tags_m                      = var.tags["frontend"]
#  component_m                 = "frontend"
#  env_m                       = var.env
#  vault_token_m               = var.vault_token
#}
#
#module "backend" {
#  depends_on = [module.mysql]
#
#  source                      = "./modules/app"
#  ami_m                       = "ami-090252cbe067a9e58"
#  instance_type_m             = "t2.micro"
#  vpc_security_group_ids_m    = var.vpc_security_group_ids
#  tags_m                      = var.tags["backend"]
#  component_m                 = "backend"
#  env_m                       = var.env
#  vault_token_m               = var.vault_token
#}
#
module "mysql" {
  source                      = "./modules/app"
  ami_m                       = var.ami
  instance_type_m             = "t2.micro"
  tags_m                      = var.tags["mysql"]
  component_m                 = "mysql"
  env_m                       = var.env
  vault_token_m               = var.vault_token
  vpc_id_m                    = module.dev-vpc.vpc_id
  subnets_m                   = module.dev-vpc.mysql_subnets
}


# VPC Code #

module "dev-vpc" {
  source              = "./modules/vpc"
  env_m               = var.env
  default-vpc-id_m    =  var.default-vpc-id
  frontend_subnets    = var.frontend_subnets
  backend_subnets     =  var.backend_subnets
  mysql_subnets       =  var.mysql_subnets
  available_zone      =  var.available_zone
}





































