resource "aws_cloudwatch_log_group" "apps" {
  name              = "/ecs/${var.deployment}/${local.service_name}"
  retention_in_days = var.logs_retention
  tags              = local.all_tags
}
