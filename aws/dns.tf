resource "aws_route53_record" "website" {
  allow_overwrite = true
  zone_id         = var.aws_route53_zone_id
  name            = var.lb_dns_name
  type            = "A"
  ttl             = 600
  records         = [var.lb_public_address]
}

resource "aws_route53_record" "challenge" {
  allow_overwrite = true
  zone_id         = var.aws_route53_zone_id
  name            = var.dns_challenge_name
  type            = "CNAME"
  ttl             = 600
  records         = [var.dns_challenge_value]
}
