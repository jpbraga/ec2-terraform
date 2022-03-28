resource "aws_security_group" "ec2_sg" {
  description = "Acesso a instancia ${var.name}-${var.env}."
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "ec2_egress" {
  type = "egress"

  protocol    = "-1"
  from_port   = 0
  to_port     = 0
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_security_group_rule" "ec2_ingress" {
  type = "ingress"

  protocol    = "tcp"
  from_port   = 443
  to_port     = 443
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_security_group_rule" "ec2_ssh_ingress" {
  count = length(var.ssh_ip_cidr_blocks) > 0 ? 1 : 0
  type  = "ingress"

  protocol    = "tcp"
  from_port   = 22
  to_port     = 22
  cidr_blocks = var.ssh_ip_cidr_blocks

  security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_security_group_rule" "ec2_http_ingress" {
  count = var.enable_http ? 1 : 0
  type  = "ingress"

  protocol    = "tcp"
  from_port   = 80
  to_port     = 80
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.ec2_sg.id
}
