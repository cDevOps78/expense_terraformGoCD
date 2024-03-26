resource "null_resource" "name1" {
  provisioner "local-exec" {
    command = "echo this is ${var.modname}"
  }
}
output "names" {
  value = var.modname
}
variable "modname" {}