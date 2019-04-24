resource "tls_private_key" "pk" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "ssc" {
  key_algorithm   = "RSA"
  private_key_pem = "${tls_private_key.pk.private_key_pem}"

  subject {
    common_name  = "${var.hosted_zone}"
    organization = "${var.hosted_zone}"
  }

  dns_names = [
    "*.${var.hosted_zone}"
  ]

  validity_period_hours = 8760

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "aws_acm_certificate" "acm_alb_ssl" {
  private_key      = "${tls_private_key.pk.private_key_pem}"
  certificate_body = "${tls_self_signed_cert.ssc.cert_pem}"

  tags = {
    Name = "${var.environment}"
  }

}
