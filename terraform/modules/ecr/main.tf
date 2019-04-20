resource "aws_ecr_repository" "nginx" {
  name = "${var.environment}-nginx"
}

resource "aws_ecr_repository" "wordpress" {
  name = "${var.environment}-wordpress"
}
