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
    command = "vesctl request secrets get-public-key > ./xc-api-pubkey"
    environment = {
      VES_P12_PASSWORD = var.TF_VES_P12_PASSWORD
    }
  }

}

resource "null_resource" "get_xc_tenant_policy" {
  provisioner "local-exec" {
    command = "vesctl request secrets get-policy-document --namespace shared --name ves-io-allow-volterra > ./xc-api-policy"
    environment = {
      VES_P12_PASSWORD = var.TF_VES_P12_PASSWORD
    }
  }
}

resource "null_resource" "blind_fold_key" {
  provisioner "local-exec" {
    command = "vesctl request secrets encrypt --policy-document xc-api-policy --public-key xc-api-pubkey priv.key > blindfold-key"
    environment = {
      VES_P12_PASSWORD = var.TF_VES_P12_PASSWORD
    }
  }
  depends_on = [null_resource.get_xc_tenant_policy, null_resource.get_xc_tenant_pubkey]
}

data "local_file" "blindfold" {
  filename = "${path.root}/blindfold-key"
}

output "blindfold_key" {
  value      = chomp(replace(data.local_file.blindfold.content, "Encrypted Secret (Base64 encoded):\n", ""))
  depends_on = [data.local_file.blindfold]
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
