output "efs_id" {
  value = "${aws_efs_file_system.efs.id}"
}

output "efs_mount_ids" {
  value = ["${aws_efs_mount_target.mount.*.id}"]
}

output "efs_mount_dns_names" {
  value = ["${aws_efs_mount_target.mount.*.dns_name}"]
}

output "efs_mount_inet_ids" {
  value = ["${aws_efs_mount_target.mount.*.network_interface_id}"]
}
