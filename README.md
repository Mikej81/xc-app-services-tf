# xc-app-services-tf

XC application services in Terraform

Example of deploying Application Services in XC using Terraform.

- Load Balancer
- WAF
- Service Policy
- Routes
  - Simple [iRule Replacement]
  - Redirect [iRule Replacement]
  - Direct Response [iRule Replacement]
  - Custom
  - [HEADER] [iRule Replacement] Accept-Language Based Redirects
  - [HEADER] [iRule Replacement] WWW-Authenticate NTLM Killer
  - [Rewrites] [iRule Replacement] Path Rewritting
  - [Rewrites] [iRule Replacement] Manual Host Rewriting
- Bot Standard
- Rate Limiting
- Client Side Defense
- App Type & App Settings (ML)

## Usage

Map the VES P12 Password to ENV Var

```bash
. ./prep.sh
```

Deploy

```bash
terraform init
terraform plan
terraform apply
```

Destroy

```bash
terraform destroy
```
