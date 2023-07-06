output "deployment_info" {
  value = {
    auto_cert_challenge_name  = module.xc.challenge_name
    auto_cert_challenge_value = module.xc.challenge_value
    http_lb_public_address    = module.xc.lb_ip_address
  }
}
