resource "random_string" "env_prefix" {
  length  = 8
  upper   = false
  special = false
}

resource "random_string" "admin_password" {
  length      = 16
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
  special     = false
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "null_resource" "get_xc_tenant_pubkey" {
  provisioner "local-exec" {
    command = "vesctl --p12-bundle ./creds/f5-sa.console.ves.volterra.io.api-creds.p12 request secrets get-public-key > xc-api-pubkey"
  }
}

resource "null_resource" "get_xc_tenant_policy" {
  provisioner "local-exec" {
    command = "vesctl --p12-bundle ./creds/f5-sa.console.ves.volterra.io.api-creds.p12 request secrets get-policy-document --namespace shared --name ves-io-allow-volterra > xc-api-policy"
  }
}

output "env_prefix" {
  value = random_string.env_prefix.result
}

output "local_public_ip" {
  value = chomp(data.http.myip.body)
}

output "admin_password" {
  value = random_string.admin_password.result
}
