variable "region" {
  description = "The AWS region."
}

variable "environment" {
  description = "The name of our environment, i.e. development"
}

variable "key_name" {
  description = "The AWS key pair to use for resources"
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
