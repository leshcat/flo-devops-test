output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "public_subnet_ids" {
  value = "${module.vpc.public_subnet_ids}"
}

output "vpc_sg_id" {
  value = "${module.vpc.vpc_sg_id}"
}

output "zone_id" {
  value = "${module.route53.zone_id}"
}

output "rds_id" {
  value = "${module.rds.rds_id}"
}

output "rds_endpoint" {
  value = "${module.rds.rds_endpoint}"
}

output "efs_id" {
  value = "${module.efs.efs_id}"
}

output "ecr_name" {
  value = "${module.ecr.ecr_name}"
}

output "ecr_url" {
  value = "${module.ecr.ecr_url}"
}

output "ami_id" {
  value = "${module.asg.ami_id}"
}

output "alc_id" {
  value = "${module.asg.alc_id}"
}

output "asg_id" {
  value = "${module.asg.asg_id}"
}

output "alb_id" {
  value = "${module.asg.alb_id}"
}

output "alb_dns_name" {
  value = "${module.asg.alb_dns_name}"
}

output "iam_ecr_role_id" {
  value = "${module.asg.iam_ecr_role_id}"
}

output "iam_ecr_role_unique_id" {
  value = "${module.asg.iam_ecr_role_unique_id}"
}
