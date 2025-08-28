resource "aws_lb" "ALB" {
  name               = "${var.app-name}-ALB"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.ALB-SG.id]
  subnets            = data.aws_subnets.default_vpc_subnets.ids
}

resource "aws_lb_target_group" "ALG-TG" {
  name     = "${var.app-name}-ALB-TG"
  port     = var.container-port
  protocol = "HTTP"
  vpc_id   = aws_default_vpc.default.id
  health_check {
    path                = var.path-check
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 5
    matcher             = "200-299"
  }
}

resource "aws_lb_listener" "ALB-Listner" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = "80"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ALG-TG.id
  }
}