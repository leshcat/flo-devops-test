provider "aws" {
  region = "${var.region}"
}

module "vpc" {
  source              = "./modules/vpc"
  environment         = "${var.environment}"
  vpc_cidr            = "${var.vpc_cidr}"
  public_subnets      = "${var.public_subnets}"
  private_subnets     = "${var.private_subnets}"
  sg_ports_allowed    = "${var.sg_ports_allowed}"
  cidr_blocks_allowed = "${var.cidr_blocks_allowed}"
  key_name            = "${var.key_name}"
}
