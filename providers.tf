terraform {
  required_providers {
    volterrarm = {
      source  = "volterraedge/volterra"
      version = "~> 0.11.30"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 2.1.0"
    }
    venafi = {
      source  = "Venafi/venafi"
      version = "~> 0.16.1"
    }
  }
}

# Configure the Venafi provider
provider "venafi" {
  api_key = var.venafi_api_key
  zone    = var.venafi_zone
}

provider "volterrarm" {
  api_p12_file = var.api_p12_file
  api_cert     = var.api_p12_file != "" ? "" : var.api_cert
  api_key      = var.api_p12_file != "" ? "" : var.api_key
  url          = var.api_url
}

provider "http" {
}
