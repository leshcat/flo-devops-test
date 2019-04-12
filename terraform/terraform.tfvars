# Aws initials
region = "us-east-1"

# Default prefix/postfix for resources
environment = "wordpress"

# Keys
key_name = "adenisevich"
key_path = "/Users/alexeydenisevich/.ssh/adenisevich.pem"

# VPC Network
vpc_cidr            = "10.77.0.0/16"
public_subnets  = ["10.77.1.0/24", "10.77.2.0/24"]
private_subnets = []

# SG ports allowed
sg_ports_allowed = ["22", "80", "8080", "443"]

# CIDR blocks allowed
cidr_blocks_allowed = ["0.0.0.0/0"]
