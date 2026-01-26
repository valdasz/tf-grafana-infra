
resource "aws_ecs_task_definition" "task" {
  family             = "${local.service_name_with_deployment}-task-definition"
  task_role_arn      = aws_iam_role.service_task_role.arn
  execution_role_arn = aws_iam_role.service_task_exec_role.arn
  network_mode       = "awsvpc"
  cpu                = var.cpu
  memory             = var.memory

  container_definitions = jsonencode([
    {
      name         = local.container_name,
      image        = "${var.image}:${var.image_version}",
      essential    = true,
      portMappings = [{ containerPort = local.container_port, hostPort = local.container_port }],

      environment = [
        for key, val in local.env_vars : {
          name  = key
          value = val
        }
      ]

      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-region"        = var.region,
          "awslogs-group"         = aws_cloudwatch_log_group.apps.name,
          "awslogs-stream-prefix" = "/${element(split("/", var.image), length(split("/", var.image)) > 1 ? 1 : 0)}/${var.image_version}/applog"
        }
      },
    }
  ])

  tags = local.all_tags
}

