# xc-app-services-tf

XC application services in Terraform

Example of deploying Application Services in XC using Terraform.

- Load Balancer
- WAF
- Service Policy
- Routes
- Bot Standard
- Client Side Defense
- App Type & App Settings (ML)

## Usage

Map the VES P12 Password to ENV Var

```
. ./prep.sh
```

Deploy

```
terraform init
terraform plan
terraform apply
```

Destroy

```
terraform destroy
```
