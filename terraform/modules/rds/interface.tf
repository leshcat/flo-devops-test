variable "environment" {
  description = "The name of your environment"
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

variable "vpc_sg_id" {
  description = "Pre-defined VPC Security Group id"
}

variable "public_subnet_ids" {
  type        = "list"
  description = "Public subnets"
}
