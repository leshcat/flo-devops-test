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
