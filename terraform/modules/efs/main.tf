resource "aws_efs_file_system" "efs" {
    creation_token = "${var.environment}"
    performance_mode = "generalPurpose"
    tags {
        Name = "${var.environment}"
    }
}

resource "aws_efs_mount_target" "mount" {
  count = "${var.subnets_count}"

  file_system_id = "${aws_efs_file_system.efs.id}"
  subnet_id      = "${element(var.public_subnet_ids, count.index)}"

  security_groups = [
    "${var.vpc_sg_id}"
  ]
}
