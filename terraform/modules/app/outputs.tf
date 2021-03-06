output "ami_id" {
  value = "${data.aws_ami.amazon_linux_2.id}"
}

output "alc_id" {
  value = "${aws_launch_configuration.alc.id}"
}

output "asg_id" {
  value = "${aws_autoscaling_group.asg.id}"
}

output "alb_id" {
  value = "${aws_alb.alb.id}"
}

output "alb_dns_name" {
  value = "${aws_alb.alb.dns_name}"
}

output "alb_zone_id" {
  value = "${aws_alb.alb.zone_id}"
}

output "iam_asg_role_id" {
  value = "${aws_iam_role.iam_asg_role.id}"
}

output "iam_asg_role_unique_id" {
  value = "${aws_iam_role.iam_asg_role.unique_id}"
}
