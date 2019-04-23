# Aws initials are taken from
# TF_VARs, i.e.: TF_VAR_region=us-east-1

# Default prefix/postfix for resources that will form "environment"
name = "wordpress"
deployment = "dev"

# EC2
ec2_key_name = "adenisevich"
ec2_instance_type = "t2.micro"

# RDS
rds_instance_type = "db.t2.micro"
rds_db_name = "wordpress"
rds_username = "wordpress"
rds_password = "wordpress"

# VPC Network
vpc_cidr            = "10.77.0.0/16"
public_subnets  = ["10.77.1.0/24", "10.77.2.0/24"]
private_subnets = []

# SG ports allowed
sg_ports_allowed = ["22", "80", "8080", "443", "2049", "3306"]

# CIDR blocks allowed
cidr_blocks_allowed = ["0.0.0.0/0"]

# Route 53
hosted_zone = "wordpress.int"
alias_record = "web.wordpress.int"
