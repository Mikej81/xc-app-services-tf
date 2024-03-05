# xc-app-services-tf

## Example(s) of deploying Application (Security) Services in F5 XC with Venafi integration for LB Cert/Key

This repo demonstrates several of the following; security service configurations, examples of how to replace iRules in XC using Service Policies and L7 Routes, Venafi integration.

- HTTP Load Balancer
  - IP Reputation
  - Dataguard
  - Source IP Stickiness
  - Venafi Cert/Key
- WAAP / WAF
  - Blocking
  - Default Detection
  - Threat Campaigns
  - Default Bot
- Service Policy
  - Allow IPv4 Prefix
  - Deny by ASN
  - Deny by Country List
  - Deny by Header
  - Deny by IP Reputation
- Routes
  - Simple
  - Redirect [iRule Replacement: HTTP::redirect]
  - Direct Response [iRule Replacement HTTP::respond]
  - Custom
  - [Rewrites] [iRule Replacement] URI Rewriting
  - [Rewrites] [iRule Replacement] Manual Host Rewriting
  - [iRule Replacement: Pool Command] when HTTP_REQUEST { set uri [HTTP::uri] if { $uri ends_with ".gif" } { pool my_pool }
- Bot Standard
  - POST /login/ protection
  - GET / Web Scraping protection
- Rate Limiting
- Client Side Defense
- App Type & App Settings (ML)
  - User Behavior Analysis (Malicious User Detection)
  - API Discovery
  - [DDoS] Time Series Analysis

## Prerequisites

This branch uses Venafi to generate cert-key pairs and import into XC Load Balancers.  You must have a Venafi deployment to use this.  This branch also wraps vesctl to blindfold private keys, so you will need to download and configure vesctl.

[https://gitlab.com/volterra.io/vesctl/blob/main/README.md](https://gitlab.com/volterra.io/vesctl/blob/main/README.md)

## Usage

Map the VES P12 Password to ENV Var

```bash
. ./example_prep.sh
```

Configure

Modify variables.tf, create tfvars or override, work with XC Specialist to configure for your needs.

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

## Support

Bugs and enhancements can be made by opening an `issue` within the `GitHub` repository.
