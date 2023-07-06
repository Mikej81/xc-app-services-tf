####################################
## Application Module - Variables ##
####################################

# Application definition

variable "name" {
  type        = string
  description = "Application name"
  default     = "random-app"
}

variable "environment" {
  type        = string
  description = "Application environment"
  default     = "dev"
}

variable "adminUserName" {
  type        = string
  description = "REQUIRED: Admin Username for All systems"
  default     = "xadmin"
}

variable "sshPublicKey" {
  type        = string
  description = "OPTIONAL: ssh public key for instances"
  default     = ""
}
variable "sshPublicKeyPath" {
  type        = string
  description = "OPTIONAL: ssh public key path for instances"
  default     = "~/.ssh/id_rsa.pub"
}


########################
## F5 XCS Variables   ##
########################

// Required Variable
variable "api_p12_file" {
  type        = string
  description = "REQUIRED:  This is the path to the Volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials"
  default     = "./creds/console.ves.volterra.io.api-creds.p12"
}

variable "api_cert" {
  type        = string
  description = "REQUIRED:  This is the path to the Volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials"
  default     = "./api2.cer"
}
variable "api_key" {
  type        = string
  description = "REQUIRED:  This is the path to the Volterra API Key.  See https://volterra.io/docs/how-to/user-mgmt/credentials"
  default     = "./api.key"
}
// Required Variable
variable "tenant_name" {
  type        = string
  description = "REQUIRED:  This is your Volterra Tenant Name:  https://<tenant_name>.console.ves.volterra.io/api"
  default     = "mr-customer"
}

########################
## AWS Variables   ##
########################

// Required Variable
variable "aws_access_key" {
  default = "access_key"
}
variable "aws_secret_key" {
  default = "key"
}

variable "aws_region" {
  default = "us-east-1"
}

// Required Variable
variable "namespace" {
}
variable "dns_domain" {
}
variable "origin_destination" {
}

// Required Variable
variable "api_url" {
  type        = string
  description = "REQUIRED:  This is your Volterra API url"
  default     = "https://mr-customer.console.ves.volterra.io/api"
}
variable "fleet_label" { default = "fleet_label" }

## TAGS
variable "tags" {
  description = "Environment tags for objects"
  type        = map(string)
  default = {
    purpose     = "public"
    environment = "aws"
    owner       = "f5owner"
    group       = "f5group"
    costcenter  = "f5costcenter"
    application = "f5app"
    creator     = "Terraform"
    delete      = "True"
  }
}
