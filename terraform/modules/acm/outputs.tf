output "acm_alb_ssl_arn" {
  value = "${aws_acm_certificate.acm_alb_ssl.arn}"
}
