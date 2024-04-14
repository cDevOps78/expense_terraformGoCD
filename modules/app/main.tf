resource "aws_instance" "instance" {
  ami           = var.ami_m
  instance_type = var.instance_type_m
  vpc_security_group_ids = var.vpc_security_group_ids_m
  tags          = merge(var.tags_m,{

    project = "expense"
    env     = "dev"
    monitor = format("%s","yes")
  })

  instance_market_options {  // block
    market_type = "spot"
    spot_options {
      instance_interruption_behavior = "stop"
      spot_instance_type             = "persistent"
    }
  }
}
resource "aws_route53_record" "record" {
  name    = "${var.component_m}-${var.env_m}.azcart.online"
  type    = "A"
  zone_id = "Z0144525QEQQSOE8RRNR"
  ttl     = 30
  records = [aws_instance.instance.private_ip]
}

resource "null_resource" "null" {
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = data.vault_kv_secret.secret_data.data["ansible_user"]
      password = data.vault_kv_secret.secret_data.data["ansible_password"]
      host     = aws_instance.instance.private_ip
    }
    inline = [
            "sudo labauto ansible",
            "ansible-pull -i localhost,-U https://github.com/cDevOps78/expenseAnsibleGoCD -e env=${var.env_m} -e component=${var.component_m} -e vault_token=${var.vault_token_m} get-vault-secrets.yaml",
            "ansible-pull -i localhost, -U https://github.com/cDevOps78/expenseAnsibleGoCD -e env=${var.env_m} -e role_name=${var.component_m} -e component=${var.component_m} -e '@${var.component_m}-secrets.json' rolecall.yaml"
    ]
  }
}



















