# --- ECS Service ---
resource "aws_security_group" "service_task" {
  name   = "${local.service_name_with_deployment}-task-sg"
  vpc_id = nonsensitive(data.aws_ssm_parameter.vpc_id.value)

  tags = merge(local.all_tags,
    {
      "Name" = "${local.service_name_with_deployment}-task-sg"
    }
  )

  dynamic "ingress" {
    for_each = [local.container_port]
    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [nonsensitive(data.aws_ssm_parameter.alb_public_security_group_id.value)]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
