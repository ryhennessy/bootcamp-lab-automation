variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "aws_profile" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "instance_count" {
  default = 1
}

variable "everything_box_instance_type" {
  type    = string
  default = "t3.large"
}

variable "leader_instance_type" {
  type    = string
  default = "t4g.small"
}

variable "worker_instance_type" {
  type    = string
  default = "t4g.small"
}

variable "my_bucket_name" {
  type    = string
  default = "cribl-training-lab"
}

variable "everything_service_ports" {
  type    = list(any)
  default = [22, 3000, 4200, 5601, 6379, 8000, 8086, 8088, 8089, 8888, 9000, 9001, 9002, 9100, 9200, 9997, 10080, 10081, 27100]
}

variable "leader_service_ports" {
  type    = list(any)
  default = [22, 9000, 4200]
}

variable "worker_service_ports" {
  type    = list(any)
  default = [22, 8088, 9514, 9997, 10070, 10080]
}

variable "aws_s3_bucket" {
  type    = string
  default = "labbuildout"
}
