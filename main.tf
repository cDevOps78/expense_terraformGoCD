provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {}
}

provider "vault" {
   address = "https://vault-internal.azcart.online:8200"
   skip_tls_verify = true
}

data "vault_kv_secret" "secret_data" {
  path = "common/ssh"
}

resource "local_file" "vault" {
  filename = "/tmp/common"
  content = data.vault_kv_secret.secret_data.data_json
}



#module "fronitend" {
#  depends_on = [module.backend]
#
#  source                      = "./modules/app"
#  ami_m                       = var.ami
#  instance_type_m             = "t2.micro"
#  vpc_security_group_ids_m    = var.vpc_security_group_ids
#  tags_m                      = var.tags["frontend"]
#  component_m                 = "frontend"
#  env_m                       = var.env
#}
#
#module "backend" {
#  depends_on = [module.mysql]
#
#  source                      = "./modules/app"
#  ami_m                       = var.ami
#  instance_type_m             = "t2.micro"
#  vpc_security_group_ids_m    = var.vpc_security_group_ids
#  tags_m                      = var.tags["backend"]
#  component_m                 = "backend"
#  env_m                       = var.env
#}
#
#module "mysql" {
#  source                      = "./modules/app"
#  ami_m                       = var.ami
#  instance_type_m             = "t2.micro"
#  vpc_security_group_ids_m    = var.vpc_security_group_ids
#  tags_m                      = var.tags["mysql"]
#  component_m                 = "mysql"
#  env_m                       = var.env
#}




































