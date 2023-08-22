output "deployment_info" {
  value = {
    create_dns_records = "Please be sure to create the following records: Type: CNAME:${var.delegated_dns_domain} Address: ${module.xc.lb_cname} \nOR Type: A Record:${var.delegated_dns_domain} IP Address: ${module.xc.lb_ip_address}"
  }
}
