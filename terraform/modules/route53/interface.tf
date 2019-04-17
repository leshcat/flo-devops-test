variable "environment" {
  description = "The name of your environment"
}

variable "hosted_zone" {
  description = "Hosted Zone name"
}

variable "alias_record" {
  description = "Alias record for ALB"
}

variable "alb_dns_name" {
  description = "ALB DNS name"
}

variable "alb_zone_id" {
  description = "ALB Zone ID"
}

variable "vpc_id" {
  description = "VPC id for hosted zone association"
}
