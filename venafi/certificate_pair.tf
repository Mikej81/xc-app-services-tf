resource "venafi_certificate" "loadbalancer" {
  common_name = var.delegated_dns_domain
  san_dns = [
    "${var.delegated_dns_domain}"
  ]
  algorithm = "RSA"
  rsa_bits  = "2048"
  #valid_days = 1-7
  #expiration_window = 720
  custom_fields = {
    "Cost Center" = "XC1234",
    "Environment" = "XC|Staging"
  }
}
output "venafi_private_key" {
  value     = venafi_certificate.loadbalancer.private_key_pem
  sensitive = true
}

output "venafi_certificate" {
  value = venafi_certificate.loadbalancer.certificate
}

output "venafi_trust_chain" {
  value = venafi_certificate.loadbalancer.chain
}

# output "venafi_p12_keystore" {
#   value = venafi_certificate.loadbalancer.pkcs12
# }
