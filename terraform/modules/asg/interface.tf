variable "environment" {
  description = "The name of your environment"
}

variable "public_subnet_ids" {
  type = "list"
  description = "Hosted Zone name"
}

variable "vpc_id" {
  description = "VPC id for hosted zone association"
}

variable "vpc_sg_id" {
  description = "Pre-defined VPC Security Group id"
}

variable "efs_id" {
  description = "EFS id"
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
}

variable "ec2_key_name" {
  description = "EC2 instance type"
}
