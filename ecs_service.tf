data "aws_ecs_cluster" "observability" {
  cluster_name = local.cluster_name
}

resource "aws_ecs_service" "service" {
  name            = local.service_name
  cluster         = data.aws_ecs_cluster.observability.id
  task_definition = aws_ecs_task_definition.task.arn
  # launch_type not needed if capacity_provider_strategy used
  desired_count                     = var.desired_number_of_tasks
  health_check_grace_period_seconds = var.health_check_grace_period_seconds

  propagate_tags         = "SERVICE"
  enable_execute_command = var.enable_execute_command
  tags                   = local.all_tags

  network_configuration {
    security_groups  = [aws_security_group.service_task.id]
    subnets          = split(",", nonsensitive(data.aws_ssm_parameter.private_subnet_ids.value))
    assign_public_ip = false
  }

  capacity_provider_strategy {
    capacity_provider = local.capacity_provider_name
    weight            = 100
  }

  # lifecycle {
  #   ignore_changes = [desired_count]
  # }

  # To prevent a race condition during service deletion, make sure to set depends_on to the related aws_iam_role_policy
  depends_on = [aws_iam_role.service_task_exec_role, aws_iam_role.service_task_role]

  load_balancer {
    target_group_arn = aws_lb_target_group.public.arn
    container_name   = local.container_name
    container_port   = local.container_port
  }

}
