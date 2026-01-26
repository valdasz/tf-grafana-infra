variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "deployment" {
  type    = string
  default = "vz"
}

variable "cluster_name" {
  type    = string
  default = ""
}

variable "capacity_provider_name" {
  type    = string
  default = ""
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "extra_env_vars" {
  type    = map(string)
  default = {}
}

variable "image" {
  type    = string
  default = "654203940570.dkr.ecr.ap-south-1.amazonaws.com/grafana-obs"
}

variable "image_version" {
  type    = string
  default = "latest"
}

variable "service_public_port" {
  type    = number
  default = 3000
}

variable "public_domain_name" {
  type    = string
  default = ""
}

variable "public_alb_listener_rules_starting_number" {
  type    = number
  default = 100
}


variable "cpu" {
  type    = number
  default = 512
}

variable "memory" {
  type    = number
  default = 256
}

variable "desired_number_of_tasks" {
  type    = number
  default = 1
}

variable "health_check_grace_period_seconds" {
  type    = number
  default = 30
}

variable "health_check_healthy_threshold" {
  type    = number
  default = 2
}


variable "health_check_unhealthy_threshold" {
  type    = number
  default = 2
}

variable "health_check_timeout" {
  type    = number
  default = 5
}

variable "health_check_interval" {
  type    = number
  default = 10
}

variable "admin_user" {
  type    = string
  default = "vz_admin"
}

variable "admin_password" {
  type    = string
  default = "vz_psw"
}

variable "logs_retention" {
  type    = number
  default = 1
}

variable "enable_execute_command" {
  type        = bool
  default     = false
  description = "To enable connect to task and execute command for troubleshooting with 'aws ecs execute-command..' "
}
