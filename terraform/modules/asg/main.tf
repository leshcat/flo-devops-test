data "aws_ami" "amazon_linux_2" {
 most_recent = true
 owners = ["amazon"]

 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }

 filter {
   name = "name"
   values = ["amzn2-ami-*-x86_64-gp2"]
 }
 filter {
   name = "virtualization-type"
   values = ["hvm"]
 }
}

data "template_file" "bootstrap" {
  #count    = "${length(aws_autoscaling_group.testme.desired_capacity)}"
  template = "${file("${path.module}/files/bootstrap.sh.tpl")}"

  vars {
    efs_id = "${var.efs_id}"
  }

}

resource "aws_launch_configuration" "testme" {
    name                        = "testme"
    image_id                    = "${data.aws_ami.amazon_linux_2.id}"
    #image_id = "ami-0de53d8956e8dcf80"

    instance_type               = "t2.micro"
    key_name                    = "adenisevich"
    security_groups             = ["${var.vpc_sg_id}"]
    associate_public_ip_address = true
    user_data            = "${data.template_file.bootstrap.rendered}"
    enable_monitoring           = false
    iam_instance_profile        = "${aws_iam_instance_profile.testme.name}"
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

resource "aws_autoscaling_group" "testme" {
    name                      = "testme"
    desired_capacity          = 2
    health_check_grace_period = 300
    health_check_type         = "EC2"
    launch_configuration      = "${aws_launch_configuration.testme.id}"
    max_size                  = 2
    min_size                  = 1

    vpc_zone_identifier       = ["${var.public_subnet_ids}"]


    tag {
        key   = "Name"
        value = "testme"
        propagate_at_launch = true
    }

}


resource "aws_alb" "testme" {
    idle_timeout    = 60
    internal        = false
    name            = "testme"

    security_groups = ["${var.vpc_sg_id}"]
    subnets         = ["${var.public_subnet_ids}"]

    enable_deletion_protection = false

    tags {
        "Name" = "testme"
    }
}

resource "aws_lb_target_group" "testme" {
  name     = "testme"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_lb_listener" "testme" {
  load_balancer_arn = "${aws_alb.testme.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.testme.arn}"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = "${aws_autoscaling_group.testme.id}"
  alb_target_group_arn   = "${aws_lb_target_group.testme.arn}"
}

resource "aws_iam_instance_profile" "testme" {
  name = "testme"
  role = "${aws_iam_role.testme.name}"
}

resource "aws_iam_role" "testme" {
    name               = "testme"
    path               = "/"
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


resource "aws_ecr_repository" "testme" {
  name = "testme"
}
