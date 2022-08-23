resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "key-${random_string.random.result}"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

data "aws_ami" "amzn2_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-arm64-gp2"]
  }
}

data "aws_ami" "amzn2_ami2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_subnet_ids" "vpc_subnets" {
  vpc_id = var.vpc_id
}

data "aws_subnet" "subnets" {
  for_each = data.aws_subnet_ids.vpc_subnets.ids
  id       = each.value
}