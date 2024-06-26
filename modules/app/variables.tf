variable "ami_m" {}
variable "instance_type_m" {}
variable "tags_m" {}
variable "env_m" {}
variable "component_m" {}
variable "vpc_id_m" {}
variable "subnets_m" {}

variable "vault_token_m" {}

variable "lb_needed" {
  default = null
}

variable "lb_type" {
  default = null
}

variable "lb_subnets" {
  default = null
}

variable "app_port" {
  default = null
}

