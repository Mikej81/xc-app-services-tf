terraform {
  required_providers {
    volterrarm = {
      source  = "volterraedge/volterra"
      version = "0.11.23"
    }
    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "volterrarm" {
  api_p12_file = var.api_p12_file
  api_cert     = var.api_p12_file != "" ? "" : var.api_cert
  api_key      = var.api_p12_file != "" ? "" : var.api_key
  url          = var.api_url
}

provider "http" {
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}
