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
