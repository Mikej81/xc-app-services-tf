# main.tf

# Util Module
# - Random Prefix Generation
# - Random Password Generation
module "util" {
  source = "./util"
}

module "xc" {
  source               = "./xc"
  projectPrefix        = module.util.env_prefix
  name                 = var.name
  namespace            = var.namespace
  tenant_name          = var.tenant_name
  environment          = var.environment
  fleet_label          = var.fleet_label
  api_url              = var.api_url
  sshPublicKeyPath     = var.sshPublicKeyPath
  sshPublicKey         = var.sshPublicKey
  api_p12_file         = var.api_p12_file
  delegated_dns_domain = var.delegated_dns_domain
  tags                 = var.tags
  lb_count             = var.lb_count
}
