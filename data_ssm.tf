### VPC data
data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.deployment}/shared/vpc/id"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.deployment}/shared/vpc/private_subnet_ids"
}

### ALB
# internal
data "aws_ssm_parameter" "alb_internal_dns_name" {
  name = "/${var.deployment}/shared/alb/internal/dns_name"
}

data "aws_ssm_parameter" "alb_internal_id" {
  name = "/${var.deployment}/shared/alb/internal/id"
}

data "aws_ssm_parameter" "alb_internal_security_group_id" {
  name = "/${var.deployment}/shared/alb/internal/security_group_id"
}


# public
data "aws_ssm_parameter" "alb_public_listener_id" {
  name = "/${var.deployment}/shared/alb/public/listener/${var.service_public_port}"
}

data "aws_ssm_parameter" "alb_public_security_group_id" {
  name = "/${var.deployment}/shared/alb/public/security_group_id"
}

