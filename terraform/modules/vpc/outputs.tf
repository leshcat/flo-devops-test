output "vpc_id" {
  value = "${aws_vpc.environment.id}"
}

output "vpc_cidr" {
  value = "${aws_vpc.environment.cidr_block}"
}

output "public_subnet_ids" {
  value = "${aws_subnet.public.*.id}"
}

output "private_subnet_ids" {
  value = "${aws_subnet.private.*.id}"
}

output "public_route_table_id" {
  value = "${aws_route_table.public.id}"
}

output "private_route_table_id" {
  value = "${aws_route_table.private.*.id}"
}

output "vpc_sg_id" {
  value = "${aws_security_group.vpc_sg.id}"
}

output "default_security_group_id" {
  value = "${aws_vpc.environment.default_security_group_id}"
}
