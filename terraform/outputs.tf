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

output "alias_fqdn" {
  value = "${module.route53.alias_fqdn}"
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

output "efs_mount_dns_names" {
  value = ["${module.efs.efs_mount_dns_names}"]
}

output "ecr_nginx_name" {
  value = "${module.ecr.ecr_nginx_name}"
}

output "ecr_nginx_url" {
  value = "${module.ecr.ecr_nginx_url}"
}

output "ecr_wordpress_name" {
  value = "${module.ecr.ecr_wordpress_name}"
}

output "ecr_wordpress_url" {
  value = "${module.ecr.ecr_wordpress_url}"
}

output "ami_id" {
  value = "${module.app.ami_id}"
}

output "alc_id" {
  value = "${module.app.alc_id}"
}

output "asg_id" {
  value = "${module.app.asg_id}"
}

output "alb_id" {
  value = "${module.app.alb_id}"
}

output "alb_dns_name" {
  value = "${module.app.alb_dns_name}"
}

output "alb_zone_id" {
  value = "${module.app.alb_zone_id}"
}

output "iam_asg_role_id" {
  value = "${module.app.iam_asg_role_id}"
}

output "iam_asg_role_unique_id" {
  value = "${module.app.iam_asg_role_unique_id}"
}
