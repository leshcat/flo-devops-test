output "ecr_nginx_name" {
  value = "${aws_ecr_repository.nginx.name}"
}

output "ecr_nginx_url" {
  value = "${aws_ecr_repository.nginx.repository_url}"
}

output "ecr_wordpress_name" {
  value = "${aws_ecr_repository.wordpress.name}"
}

output "ecr_wordpress_url" {
  value = "${aws_ecr_repository.wordpress.repository_url}"
}
