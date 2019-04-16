output "rds_id" {
  value = "${aws_db_instance.mysql.id}"
}

output "rds_endpoint" {
  value = "${aws_db_instance.mysql.endpoint}"
}
