# resource "aws_route53_record" "website" {
#   zone_id = aws_route53_zone.primary.zone_id
#   name    = var.dns_domain
#   type    = "A"
#   ttl     = 3600
#   records = "IP"
# }

# resource "aws_route53_record" "challenge" {
#   zone_id = aws_route53_zone.primary.zone_id
#   name    = "_acme-challenge.${var.dns_domain}"
#   type    = "CNAME"
#   ttl     = 3600
#   records = "challenge value"
# }
