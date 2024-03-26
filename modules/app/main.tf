resource "null_resource" "name2" {
  provisioner "local-exec" {
    command = "echo this is ${var.modname}"
  }
}

resource "null_resource" "name1" {
  provisioner "local-exec" {
    command = "echo this is ${var.modname}"
  }
}
variable "modname" {}