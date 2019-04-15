resource "aws_efs_file_system" "testme" {
    creation_token = "testme"
    performance_mode = "generalPurpose"
    tags {
        Name = "testme"
    }
}

resource "aws_efs_mount_target" "testme" {
  count = "${var.subnets_count}"

  file_system_id = "${aws_efs_file_system.testme.id}"
  subnet_id      = "${element(var.public_subnet_ids, count.index)}"

  security_groups = [
    "${var.vpc_sg_id}"
  ]
}
