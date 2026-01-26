locals {
  service_name                 = "grafana"
  service_name_with_deployment = "${var.deployment}-${local.service_name}"
  service_public_tg_name       = "${var.deployment}-grafana-pub"
  service_public_dns_name      = var.public_domain_name
  public_service_host_header   = length(local.service_public_dns_name) > 0 ? "${local.service_public_dns_name}.*" : ""

  cluster_name           = length(var.cluster_name) > 0 ? var.cluster_name : "${var.deployment}-ecs-observability"
  capacity_provider_name = length(var.capacity_provider_name) > 0 ? var.capacity_provider_name : "${var.deployment}-observability-capacity-provider"
  container_name         = "${local.service_name}-container"
  container_port         = 3000
  health_check_path      = "/api/health"
  health_check_protocol  = "HTTP"
  influx_port            = 8428
  influx_url             = "http://${data.aws_ssm_parameter.alb_internal_dns_name.value}:${local.influx_port}"

  env_vars = merge(
    {
      "PROMETHEUS_URL"             = local.influx_url
      "AWS_REGION"                 = var.region
      "GF_SECURITY_ADMIN_USER"     = var.admin_user
      "GF_SECURITY_ADMIN_PASSWORD" = var.admin_password
    },
    var.extra_env_vars
  )

  all_tags = merge(
    var.tags,
    {
      "deployment" = var.deployment
      "tf-source"  = "tf-grafana-infra"
    }
  )
}