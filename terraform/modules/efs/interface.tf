variable "environment" {
  description = "The name of your environment"
}

variable "public_subnet_ids" {
  type = "list"
  description = "Hosted Zone name"
}

variable "vpc_sg_id" {
  description = "Pre-defined VPC Security Group id"
}

variable "subnets_count" {
  description = "Subnets count for EFS mounts"
}
