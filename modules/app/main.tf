resource "aws_instance" "instance" {
  ami           = var.ami_m
  instance_type = var.instance_type_m
  vpc_security_group_ids = var.vpc_security_group_ids_m
  tags          = var.tags_m
}