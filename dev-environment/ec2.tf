data "aws_ami" "amazon_linux_x86" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


data "aws_ami" "amazon_linux_arm" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-arm64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["arm64"]
  }
}


locals {
  ami_id        = var.ec2_architecture == "arm" ? data.aws_ami.amazon_linux_arm.id : data.aws_ami.amazon_linux_x86.id
  instance_type = var.ec2_architecture == "arm" ? var.arm_instance_type : var.x86_instance_type
}


resource "aws_instance" "dev_ec2" {
  ami                         = local.ami_id
  instance_type               = local.instance_type
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  key_name                    = var.key_pair_name
  associate_public_ip_address = true


  root_block_device {
    volume_type           = "gp3"
    volume_size           = 20
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name        = "dev-ec2-${var.ec2_architecture}"
    Architecture = var.ec2_architecture
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}
