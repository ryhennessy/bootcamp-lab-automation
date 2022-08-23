resource "aws_instance" "everything_box" {
  ami           = data.aws_ami.amzn2_ami2.id
  instance_type = var.everything_box_instance_type
  key_name      = aws_key_pair.ec2_key.key_name
  subnet_id     = element(flatten([for s in data.aws_subnet.subnets : s.id]), 0)
  user_data = templatefile("${path.module}/templates/user_data.sh", {
    aws_s3_bucket = var.my_bucket_name
    outputs_yml   = templatefile("${path.module}/templates/outputs.tpl", { private_ips = aws_instance.worker.*.private_ip })
  })
  iam_instance_profile = aws_iam_instance_profile.ec2InstanceProfile.id

  vpc_security_group_ids = [
    aws_security_group.everything_box.id
  ]

  root_block_device {
    volume_size = 60
  }

  tags = {
    Name      = "Everything_Box"
    Permanent = "True"
  }
}

resource "aws_security_group" "everything_box" {
  name        = "everything-${random_string.random.result}-box"
  description = "Datagen, Elastic, Splunk, Syslog, Redis, etc. ${random_string.random.result}"
  vpc_id      = data.aws_vpc.vpc.id
  dynamic "ingress" {
    for_each = var.everything_service_ports
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