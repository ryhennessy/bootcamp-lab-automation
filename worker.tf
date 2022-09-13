resource "aws_instance" "worker" {
  ami           = data.aws_ami.amzn2_ami.id
  instance_type = var.worker_instance_type
  key_name      = aws_key_pair.ec2_key.key_name
  subnet_id     = element(data.aws_subnets.subnets.ids, random_integer.subnet_index.result)
  tags = {
    Name      = "Worker_${terraform.workspace}_Box"
    Permanent = "True"
  }

  vpc_security_group_ids = [
    aws_security_group.worker.id
  ]
}

resource "aws_security_group" "worker" {
  name        = "student-${random_string.random.result}-worker"
  description = "Worker node for Student ${random_string.random.result}"
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = var.worker_service_ports
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
