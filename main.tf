provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {}
}

#provider "vault" {
#  address = "https://vault-internal.azcart.online:8200"
#
#  # token = ""   VAULT_TOKEN
#  skip_tls_verify = true  # VAULT_SKIP_VERIFY
#}

module "frontend" {
  depends_on = [module.backend]

  source                      = "./modules/app"
  ami_m                       = "ami-090252cbe067a9e58"
  instance_type_m             = "t2.micro"
  tags_m                      = var.tags["frontend"]
  component_m                 = "frontend"
  env_m                       = var.env
  vault_token_m               = var.vault_token
  vpc_id_m                    = module.dev-vpc.vpc_id
  subnets_m                   = module.dev-vpc.frontend_subnets
  lb_needed                   = true
  lb_type                     = "public"
  lb_subnets                  = module.dev-vpc.public_subnets
  app_port                    = 80
}

module "backend" {
  depends_on = [module.mysql]

  source                      = "./modules/app"
  ami_m                       = "ami-090252cbe067a9e58"
  instance_type_m             = "t2.micro"
  tags_m                      = var.tags["backend"]
  component_m                 = "backend"
  env_m                       = var.env
  vault_token_m               = var.vault_token
  vpc_id_m                    = module.dev-vpc.vpc_id
  subnets_m                   = module.dev-vpc.backed_subnets
  lb_needed                   = true
  lb_type                     = "private"
  lb_subnets                  = module.dev-vpc.backed_subnets
  app_port                    = 8080

}

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
  lb_needed                   = false
}


# VPC Code #

module "dev-vpc" {
  source              = "./modules/vpc"
  env_m               = var.env
  default-vpc-id_m    = var.default-vpc-id
  frontend_subnets    = var.frontend_subnets
  backend_subnets     = var.backend_subnets
  mysql_subnets       = var.mysql_subnets
  available_zone      = var.available_zone
  public_subnets      = var.public_subnets
}





































