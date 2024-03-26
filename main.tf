provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {}
}

module "chaitu" {
  source = "./modules/app"
  modname = var.mainname
}

variable "mainname" {}
