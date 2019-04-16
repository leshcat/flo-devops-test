resource "aws_db_instance" "mysql" {
    port                      = 3306
    publicly_accessible       = false
    allocated_storage         = 20
    storage_type              = "gp2"
    engine                    = "mysql"
    engine_version            = "5.6.40"
    parameter_group_name      = "default.mysql5.6"
    multi_az                  = false
    backup_retention_period   = 7
    backup_window             = "20:06-20:36"
    maintenance_window        = "fri:22:08-fri:22:38"

    identifier                = "${var.environment}"
    name                      = "${var.rds_db_name}"
    instance_class            = "${var.rds_instance_type}"
    username                  = "${var.rds_username}"
    password                  = "${var.rds_password}"

    vpc_security_group_ids    = ["${var.vpc_sg_id}"]

    db_subnet_group_name = "${aws_db_subnet_group.mysql.name}"
}


resource "aws_db_subnet_group" "mysql" {
  name       = "${var.environment}"
  subnet_ids = ["${var.public_subnet_ids}"]

  tags = {
    Name = "Default subnet group for environment: ${var.environment}"
  }
}
