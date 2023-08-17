output "deployment_info" {
  value = {
    create_dns_records = "Please be sure to create the following records: Type: CNAME Address: ${module.xc.lb_cname} OR Type: A Record:${var.delegated_dns_domain} IP Address: ${module.xc.lb_ip_address}"
    #http_lb_public_address = module.xc.lb_ip_address
    #lb_dns_address         = module.xc.lb_dns_address
    #lb_dns_value           = module.xc.lb_dns_value
  }
}
