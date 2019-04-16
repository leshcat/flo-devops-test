variable "region" {
  description = "The AWS region to operate in"
}

variable "name" {
  description = "The name of our environment, i.e.: 'wordpress' used as prefix"
}

variable "deployment" {
  description = "The name of our deployment type, i.e.: 'dev|prod', used as postfix"
}

variable "vpc_cidr" {
  description = "The CIDR of the VPC"
}

variable "public_subnets" {
  default     = []
  description = "The list of public subnets to populate"
}

variable "private_subnets" {
  default     = []
  description = "The list of private subnets to populate"
}

variable "sg_ports_allowed" {
  type        = "list"
  description = "The list of ports that will be allowed in vpc-designated SG"
}

variable "cidr_blocks_allowed" {
  type        = "list"
  description = "The list of CIDR blocks that will be allowed in SG (and other places)"
}

variable "hosted_zone" {
  description = "Hosted Zone name"
}

variable "rds_db_name" {
  description = "RDS DB name"
}

variable "rds_instance_type" {
  description = "RDS instance type"
}

variable "rds_username" {
  description = "RDS username"
}

variable "rds_password" {
  description = "RDS password"
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
}

variable "ec2_key_name" {
  description = "EC2 instance type"
}
