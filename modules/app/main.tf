resource "aws_instance" "instance" {
  ami           = var.ami_m
  instance_type = var.instance_type_m
  vpc_security_group_ids = var.vpc_security_group_ids_m
  tags          = var.tags_m
}
resource "aws_route53_record" "record" {
  name    = "${var.component_m}-${var.env_m}.chaithanya.online"
  type    = "A"
  zone_id = "Z03998933DKS43BUYGV0L"
  ttl     = 30
  records = [aws_instance.instance.private_ip]
}
#
#resource "null_resource" "null" {
#  provisioner "remote-exec" {
#    connection {
#      type     = "ssh"
#      user     = "ec2-user"
#      password = "DevOps321"
#      host     = aws_instance.instance.private_ip
#    }
#    inline = [
#           "sudo labauto ansible",
#           "ansible-pull -i localhost, -U https://github.com/cDevOps78/expenseAnsibleGoCD -e env=${var.env_m} -e role_name=${var.component_m} -e component=${var.component_m} rolecall.yaml"
#    ]
#  }
#}