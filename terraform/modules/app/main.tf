data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "template_file" "bootstrap" {
  template = "${file("${path.module}/files/bootstrap.sh.tpl")}"

  vars {
    efs_id = "${var.efs_id}"
  }
}

resource "null_resource" "ensure_efs_available" {
  triggers {
      always_trigger = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = <<-EOT
      ansible-playbook efs_check_state.yml -e "efs_id=${var.efs_id}"
    EOT
    working_dir = "${path.module}/../../../ansible"
  }
}

resource "aws_launch_configuration" "alc" {
  name     = "${var.environment}"
  image_id = "${data.aws_ami.amazon_linux_2.id}"

  instance_type   = "${var.ec2_instance_type}"
  key_name        = "${var.ec2_key_name}"
  security_groups = ["${var.vpc_sg_id}"]

  user_data = "${data.template_file.bootstrap.rendered}"

  iam_instance_profile = "${aws_iam_instance_profile.iam_instance_profile.name}"

  associate_public_ip_address = true
  enable_monitoring           = false
  ebs_optimized               = false

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                      = "${var.environment}"
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  launch_configuration      = "${aws_launch_configuration.alc.id}"
  max_size                  = 2
  min_size                  = 1

  vpc_zone_identifier = ["${var.public_subnet_ids}"]

  tag {
    key                 = "Name"
    value               = "${var.environment}"
    propagate_at_launch = true
  }

  depends_on = ["null_resource.ensure_efs_available"]
}

resource "aws_alb" "alb" {
  idle_timeout = 60
  internal     = false
  name         = "${var.environment}"

  security_groups = ["${var.vpc_sg_id}"]
  subnets         = ["${var.public_subnet_ids}"]

  enable_deletion_protection = false

  tags {
    "Name" = "${var.environment}"
  }
}

resource "aws_lb_target_group" "albtg" {
  name     = "${var.environment}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_lb_listener" "alblistener" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.albtg.arn}"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = "${aws_autoscaling_group.asg.id}"
  alb_target_group_arn   = "${aws_lb_target_group.albtg.arn}"
}

resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = "${var.environment}"
  role = "${aws_iam_role.iam_ecr_role.name}"
}

resource "aws_iam_role" "iam_ecr_role" {
  name = "${var.environment}"
  path = "/"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [

    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy" "iam_ecr_policy" {
  name = "${var.environment}-ecr"
  role = "${aws_iam_role.iam_ecr_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
