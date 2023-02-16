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

output "env_prefix" {
  value = random_string.env_prefix.result
}

output "local_public_ip" {
  value = chomp(data.http.myip.body)
}

output "admin_password" {
  value = random_string.admin_password.result
}
