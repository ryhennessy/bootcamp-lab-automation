resource "aws_instance" "leader" {
  ami           = data.aws_ami.amzn2_ami.id
  instance_type = var.leader_instance_type
  key_name      = aws_key_pair.ec2_key.key_name
  subnet_id     = element(flatten([for s in data.aws_subnet.subnets : s.id]), 0)
  tags = {
    Name      = "Leader-${count.index + 1}"
    Permanent = "True"
  }

  vpc_security_group_ids = [
    aws_security_group.leader.id
  ]
}

resource "aws_security_group" "leader" {
  name        = "student-${random_string.random.result}-leader"
  description = "Leader node for Student ${random_string.random.result}"
  vpc_id      = data.aws_vpc.vpc.id
  dynamic "ingress" {
    for_each = var.leader_service_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
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
