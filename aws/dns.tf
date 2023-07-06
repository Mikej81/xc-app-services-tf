# resource "aws_route53_record" "website" {
#   zone_id = aws_route53_zone.primary.zone_id
#   name    = var.lb_dns_name
#   type    = "A"
#   ttl     = 3600
#   records = var.lb_public_address
# }

# resource "aws_route53_record" "challenge" {
#   zone_id = aws_route53_zone.primary.zone_id
#   name    = var.dns_challenge_name #"_acme-challenge.${var.dns_domain}"
#   type    = "CNAME"
#   ttl     = 3600
#   records = var.dns_challenge_value
# }
