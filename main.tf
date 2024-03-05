# main.tf

module "venafi" {
  source               = "./venafi"
  delegated_dns_domain = var.delegated_dns_domain
}

# Util Module
# - Random Prefix Generation
# - Random Password Generation
# - vesctl wrapper
module "util" {
  depends_on          = [module.venafi]
  source              = "./util"
  TF_VES_P12_PASSWORD = var.TF_VES_P12_PASSWORD
}

module "xc" {
  depends_on            = [module.venafi, module.util]
  source                = "./xc"
  projectPrefix         = module.util.env_prefix
  name                  = var.name
  namespace             = var.namespace
  tenant_name           = var.tenant_name
  environment           = var.environment
  fleet_label           = var.fleet_label
  api_url               = var.api_url
  sshPublicKeyPath      = var.sshPublicKeyPath
  sshPublicKey          = var.sshPublicKey
  api_p12_file          = var.api_p12_file
  delegated_dns_domain  = var.delegated_dns_domain
  venafi_private_key    = module.venafi.venafi_private_key
  blindfold_private_key = module.util.blindfold_key
  venafi_certificate    = module.venafi.venafi_certificate
  venafi_trust_chain    = module.venafi.venafi_trust_chain
  tags                  = var.tags
}
