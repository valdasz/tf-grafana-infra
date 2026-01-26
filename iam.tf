resource "aws_iam_role" "service_task_exec_role" {
  name               = "${local.service_name_with_deployment}-task-exec"
  assume_role_policy = data.aws_iam_policy_document.service_service_task.json
  tags               = local.all_tags
}

resource "aws_iam_role_policy_attachment" "ecs_exec_role_policy" {
  role       = aws_iam_role.service_task_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# --- ECS Task Role ---
data "aws_iam_policy_document" "service_service_task" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "service_task_role" {
  name               = "${local.service_name_with_deployment}-task"
  assume_role_policy = data.aws_iam_policy_document.service_service_task.json
  tags               = local.all_tags
}


