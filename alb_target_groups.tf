resource "aws_lb_target_group" "public" {
  name        = local.service_public_tg_name
  vpc_id      = nonsensitive(data.aws_ssm_parameter.vpc_id.value)
  protocol    = "HTTP"
  port        = local.container_port
  target_type = "ip"

  health_check {
    enabled             = true
    path                = local.health_check_path
    port                = local.container_port
    protocol            = local.health_check_protocol
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    timeout             = var.health_check_timeout
    interval            = var.health_check_interval
  }

  tags = local.all_tags
}

resource "aws_alb_listener_rule" "public_path_to_service" {
  listener_arn = nonsensitive(data.aws_ssm_parameter.alb_public_listener_id.value)
  priority     = var.public_alb_listener_rules_starting_number

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public.arn
  }

  dynamic "condition" {
    for_each = local.public_service_host_header != "" ? [1] : []

    content {
      host_header {
        values = [local.public_service_host_header]
      }
    }
  }
}

