provider "aws" {
  region = "${var.region}"
}

module "vpc" {
  source              = "./modules/vpc"
  environment         = "${var.name}-${var.deployment}"
  vpc_cidr            = "${var.vpc_cidr}"
  public_subnets      = "${var.public_subnets}"
  private_subnets     = "${var.private_subnets}"
  sg_ports_allowed    = "${var.sg_ports_allowed}"
  cidr_blocks_allowed = "${var.cidr_blocks_allowed}"
}

module "route53" {
  source       = "./modules/route53"
  environment  = "${var.name}-${var.deployment}"
  hosted_zone  = "${var.hosted_zone}"
  alias_record = "${var.alias_record}"
  vpc_id       = "${module.vpc.vpc_id}"
  alb_dns_name = "${module.app.alb_dns_name}"
  alb_zone_id  = "${module.app.alb_zone_id}"
}

module "efs" {
  environment       = "${var.name}-${var.deployment}"
  source            = "./modules/efs"
  subnets_count     = "${length(var.public_subnets)}"
  public_subnet_ids = "${module.vpc.public_subnet_ids}"
  vpc_sg_id         = "${module.vpc.vpc_sg_id}"
}

module "rds" {
  source      = "./modules/rds"
  environment = "${var.name}-${var.deployment}"

  rds_db_name       = "${var.rds_db_name}"
  rds_instance_type = "${var.rds_instance_type}"
  rds_username      = "${var.rds_username}"
  rds_password      = "${var.rds_password}"

  vpc_sg_id         = "${module.vpc.vpc_sg_id}"
  public_subnet_ids = "${module.vpc.public_subnet_ids}"
}

module "ecr" {
  source      = "./modules/ecr"
  environment = "${var.name}-${var.deployment}"
}

module "acm" {
  source      = "./modules/acm"
  environment = "${var.name}-${var.deployment}"
  hosted_zone = "${var.hosted_zone}"
}

module "app" {
  source              = "./modules/app"
  region              = "${var.region}"
  environment         = "${var.name}-${var.deployment}"
  public_subnet_ids   = "${module.vpc.public_subnet_ids}"
  vpc_id              = "${module.vpc.vpc_id}"
  vpc_sg_id           = "${module.vpc.vpc_sg_id}"
  efs_id              = "${module.efs.efs_id}"
  acm_alb_ssl_arn     = "${module.acm.acm_alb_ssl_arn}"
  efs_mount_dns_names = "${module.efs.efs_mount_dns_names}"
  ec2_instance_type   = "${var.ec2_instance_type}"
  ec2_key_name        = "${var.ec2_key_name}"

}
