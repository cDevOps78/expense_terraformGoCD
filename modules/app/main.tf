resource "null_resource" "name" {
  provisioner "local-exec" {
    command = "echo this is ${var.modname}"
  }
}

variable "modname" {}