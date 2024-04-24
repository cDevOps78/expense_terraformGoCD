resource "aws_security_group" "security_group" {
  name = "${var.component_m}-${var.env_m}-sg"
  vpc_id      = var.vpc_id_m

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.component_m}-${var.env_m}-sg"
  }

}




resource "aws_instance" "instance" {
  ami                      = var.ami_m
  instance_type            = var.instance_type_m
  vpc_security_group_ids   = [aws_security_group.security_group.id]
  subnet_id                = var.subnets_m[0]
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

#resource "aws_route53_record" "record" {
#  name    = "${var.component_m}-${var.env_m}.azcart.online"
#  type    = "A"
#  zone_id = "Z0144525QEQQSOE8RRNR"
#  ttl     = 30
#  records = [aws_instance.instance.private_ip]
#}

#resource "null_resource" "null" {
#  provisioner "remote-exec" {
#    connection {
#      type     = "ssh"
#      user     = data.vault_kv_secret.secret_data.data["ansible_user"]
#      password = data.vault_kv_secret.secret_data.data["ansible_password"]
#      host     = aws_instance.instance.private_ip
#    }
#    inline = [
#            "sudo labauto ansible",
#            "sudo pip3.11 install hvac",
#            "ansible-pull -i localhost, -U https://github.com/cDevOps78/expenseAnsibleGoCD -e env=${var.env_m} -e component=${var.component_m} -e vault_token=${var.vault_token_m} get-vault-secrets.yaml",
#            "ansible-pull -i localhost, -U https://github.com/cDevOps78/expenseAnsibleGoCD -e env=${var.env_m} -e role_name=${var.component_m} -e component=${var.component_m} -e @~/${var.component_m}-secrets.json rolecall.yaml"
#    ]
#  }
#}

# LoadBalancer

resource "aws_lb" "test" {
  count              = var.lb_needed ? 1 : 0
  name               = "${var.env_m}-${var.component_m}-lb"
  internal           =  var.lb_type == "private" ? true : false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.security_group.id]
  subnets            = var.lb_subnets
  tags = {
    Environment = "${var.env_m}-${var.component_m}-${var.lb_type}-lb"
  }
}

resource "aws_lb_target_group" "test" {
  count    = var.lb_needed ? 1 : 0
  name     = "${var.env_m}-${var.component_m}-tg"
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id_m
}

resource "aws_lb_target_group_attachment" "test" {
  count            = var.lb_needed ? 1 : 0
  target_group_arn = aws_lb_target_group.test[0].arn
  target_id        = aws_instance.instance.id
  port             = var.app_port
}

resource "aws_lb_listener" "main" {
  count             = var.lb_needed ? 1 : 0
  load_balancer_arn = aws_lb.test[0].arn
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test[0].arn
  }
}



















