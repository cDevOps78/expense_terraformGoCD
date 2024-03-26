provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {}
}

output "environment" {
  value = var.env
}

variable "env" {}

output "my-env" {
  value = "prod-env-environments"
}