data "aws_route53_zone" "public" {
  name         = "${var.dns_name}."
  private_zone = false
}

resource "aws_route53_record" "public" {
  zone_id = data.aws_route53_zone.public.zone_id
  name    = local.service_public_dns_name
  type    = "A"
  # ttl for alias records is 60 seconds

  alias {
    evaluate_target_health = false
    name                   = nonsensitive(data.aws_ssm_parameter.alb_public_dns_name.value)
    zone_id                = nonsensitive(data.aws_ssm_parameter.alb_public_zone_id.value)
  }
}

