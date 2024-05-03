data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.AWS_VPC_ID]
  }
}

resource "aws_lb" "ap_alb" {
  name               = "${var.PREFIX}-ap-alb"
  internal           = false
  load_balancer_type = "application"


  security_groups = [var.SG_AP_INSTANCES_ID]
  subnets         = data.aws_subnets.default_subnets.ids

  enable_deletion_protection = true
}

resource "aws_lb_target_group" "ap_alb_tg" {
  name        = "${var.PREFIX}-ap-alb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.AWS_VPC_ID
}

resource "aws_lb_listener" "ap_alb_listener" {
  load_balancer_arn = aws_lb.ap_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ap_alb_tg.arn
  }
}

output "alb_endpoint" {
  value = aws_lb.ap_alb.dns_name
}
