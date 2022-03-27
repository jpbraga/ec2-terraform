data "aws_ami" "amazon-linux-2" {
  most_recent = true


  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "ec2_web_server" {
  ami                         = data.aws_ami.amazon-linux-2.id
  instance_type               = "t2.micro"
  key_name                    = var.key_name != "" ? var.key_name : local.key_pair_name
  associate_public_ip_address = true
  security_groups             = [aws_security_group.ec2_sg.id]
  subnet_id                   = var.public_subnet_id
  user_data                   = file("${abspath(path.module)}/init.sh")
  iam_instance_profile        = aws_iam_instance_profile.ec2_monitoring_profile.name
  user_data_replace_on_change = true
  tags = {
    Name = local.instance_name
  }
}

resource "aws_iam_instance_profile" "ec2_monitoring_profile" {
  name = "ec2_monitoring_profile"
  role = aws_iam_role.monitoring.name
}
