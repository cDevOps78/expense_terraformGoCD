variable "ami" {}
// variable "instance_type" {}
variable "vpc_security_group_ids" {}
variable "tags" {}
variable "env" {}
variable "vault_token" {}


# VPC

variable "default-vpc-id" {}

variable "frontend_subnets" {}
variable "backend_subnets" {}
variable "mysql_subnets" {}

variable "available_zone" {}
variable "public_subnets" {}


