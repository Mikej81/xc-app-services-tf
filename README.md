# xc-app-services-tf

## Example(s) of deploying Application (Security) Services in F5 XC using Terraform

This repo demonstrates many of the security service configurations as well as examples of how to replace iRules in XC using Service Policies and L7 Routes.

This branch has been significantly modified to demonstrate auto_cert challenge integration into AWS Route 53.

## Usage

Map the VES P12 Password to ENV Var

```bash
. ./example_prep.sh
```

Deploy

```bash
terraform init (-upgrade as needed)
terraform plan
terraform apply --auto-approve -var 'dns_domain=LoadBalancerDomain.com' -var 'origin_destination=LoadBalancerDestination.com'
```

Destroy

```bash
terraform destroy --auto-approve -var 'dns_domain=LoadBalancerDomain.com' -var 'origin_destination=LoadBalancerDestination.com'
```

## Support

Bugs and enhancements can be made by opening an `issue` within the `GitHub` repository.
