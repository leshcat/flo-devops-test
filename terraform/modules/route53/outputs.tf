output "zone_id" {
  value = "${aws_route53_zone.private.zone_id}"
}

output "alias_fqdn" {
  value = "${aws_route53_record.alias.fqdn}"
}
