resource "aws_route53_zone" "private" {
  name = "${var.hosted_zone}"

  vpc {
    vpc_id = "${var.vpc_id}"
  }

  tags {
    Name = "${var.environment}"
  }

  comment = "Terraform provisioned for environment: ${var.environment}"
}

resource "aws_route53_record" "alias" {
  zone_id = "${aws_route53_zone.private.zone_id}"
  name    = "${var.alias_record}"
  type    = "A"

  alias {
    name                   = "${var.alb_dns_name}"
    zone_id                = "${var.alb_zone_id}"
    evaluate_target_health = false
  }
}
