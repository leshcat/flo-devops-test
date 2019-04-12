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

variable "enable_dns_hostnames" {
  description = "Should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "map_public_ip_on_launch" {
  description = "Should be false if you do not want to auto-assign public IP on launch"
  default     = true
}
