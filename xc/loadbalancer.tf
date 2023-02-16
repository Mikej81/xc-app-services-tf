
resource "volterra_origin_pool" "crunchy" {
  name      = "tforigin"
  namespace = var.namespace

  endpoint_selection     = "LOCAL_PREFERRED"
  loadbalancer_algorithm = "LB_OVERRIDE"

  origin_servers {

    public_name {
      dns_name = "coleman.myedgedemo.com"
    }

    labels = {
      "key1" = "value1"
    }
  }
  port = 443

  use_tls {
    use_host_header_as_sni = true
    tls_config {
      default_security = true
    }
    skip_server_verification = true
    no_mtls                  = true
  }
}

resource "volterra_http_loadbalancer" "example" {
  name      = "crunchy-web"
  namespace = var.namespace

  advertise_on_public_default_vip = true
  disable_api_definition          = true
  disable_api_discovery           = true
  no_challenge                    = true
  disable_ddos_detection          = true

  domains = ["crunch.${var.delegated_dns_domain}"]

  round_robin = true

  // One of the arguments from this list "https_auto_cert https http" must be set

  http {
    dns_volterra_managed = true
    port                 = "80"
  }
  // One of the arguments from this list "enable_malicious_user_detection disable_malicious_user_detection" must be set
  enable_malicious_user_detection = true

  disable_rate_limit = true

  // One of the arguments from this list "service_policies_from_namespace no_service_policies active_service_policies" must be set
  service_policies_from_namespace = true

  disable_trust_client_ip_headers = true

  // One of the arguments from this list "user_id_client_ip user_identification" must be set
  user_id_client_ip = true
  // One of the arguments from this list "disable_waf app_firewall" must be set
  disable_waf = true

  routes {
    redirect_route {
      http_method = "ANY"
      path {
        path = "/"
      }
      headers {
        name         = "Accept-Language"
        regex        = "(.*[fF][rR]-[fF][rR].*$)"
        invert_match = false
      }
      route_redirect {
        proto_redirect    = "incoming-proto"
        host_redirect     = "dummy.f5-sa.myedgedemo.com"
        path_redirect     = "/fr/"
        response_code     = "301"
        retain_all_params = true
        port_redirect     = 0
      }
    }
  }
  routes {
    redirect_route {
      http_method = "ANY"
      path {
        path = "/"
      }
      headers {
        name         = "Accept-Language"
        regex        = "(.*[pP][tT]-[bB][rR].*)"
        invert_match = false
      }
      route_redirect {
        proto_redirect    = "incoming-proto"
        host_redirect     = "dummy.f5-sa.myedgedemo.com"
        path_redirect     = "/pt/"
        response_code     = "301"
        retain_all_params = true
        port_redirect     = 0
      }
    }
  }
  routes {
    redirect_route {
      http_method = "ANY"
      path {
        path = "/"
      }
      headers {
        name         = "Accept-Language"
        regex        = "(.*[eE][sS]-[0-9].*$)"
        invert_match = false
      }
      route_redirect {
        proto_redirect    = "incoming-proto"
        host_redirect     = "dummy.f5-sa.myedgedemo.com"
        path_redirect     = "/es/"
        response_code     = "301"
        retain_all_params = true
        port_redirect     = 0
      }
    }
  }
  routes {
    simple_route {
      http_method = "ANY"
      path {
        prefix = "/en-us/"
      }
      origin_pools {
        pool {
          namespace = var.namespace
          name      = volterra_origin_pool.crunchy.name
        }
        weight   = 1
        priority = 1
      }
    }
  }
  routes {
    simple_route {
      http_method = "ANY"
      path {
        prefix = "/es/"
      }
      origin_pools {
        pool {
          namespace = var.namespace
          name      = volterra_origin_pool.crunchy.name
        }
        weight   = 1
        priority = 1
      }
    }
  }
  routes {
    redirect_route {
      http_method = "ANY"
      path {
        path = "/"
      }
      headers {
        name         = "Accept-Language"
        regex        = "(.*[eE][nN]-[uU][sS].*$)"
        invert_match = false
      }
      route_redirect {
        proto_redirect    = "incoming-proto"
        host_redirect     = "dummy.f5-sa.myedgedemo.com"
        path_redirect     = "/en-us/"
        response_code     = "301"
        retain_all_params = true
        port_redirect     = 0
      }
    }
  }
  routes {
    simple_route {
      http_method = "ANY"
      path {
        prefix = "/fr/"
      }
      origin_pools {
        pool {
          namespace = var.namespace
          name      = volterra_origin_pool.crunchy.name
        }
        weight   = 1
        priority = 1
      }
    }
  }
  routes {
    simple_route {
      http_method = "ANY"
      path {
        prefix = "/pt/"
      }
      origin_pools {
        pool {
          namespace = var.namespace
          name      = volterra_origin_pool.crunchy.name
        }
        weight   = 1
        priority = 1
      }
    }
  }

}
