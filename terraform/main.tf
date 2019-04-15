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

module "route53" {
  source      = "./modules/route53"
  hosted_zone = "${var.hosted_zone}"
  vpc_id      = "${module.vpc.vpc_id}"
}

module "asg" {
  source      = "./modules/asg"
  public_subnet_ids = "${module.vpc.public_subnet_ids}"
  vpc_id = "${module.vpc.vpc_id}"
  vpc_sg_id = "${module.vpc.vpc_sg_id}"
}
