
resource "volterra_namespace" "namespace" {
  name = var.namespace
}

resource "volterra_origin_pool" "origin" {
  depends_on = [volterra_namespace.namespace]
  name       = "${var.name}-origin"
  namespace  = var.namespace

  endpoint_selection     = "LOCAL_PREFERRED"
  loadbalancer_algorithm = "LB_OVERRIDE"

  origin_servers {

    public_name {
      dns_name = var.origin_destination
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

resource "volterra_http_loadbalancer" "appProxy" {
  depends_on = [volterra_namespace.namespace]
  name       = "${var.name}-http-lb"
  namespace  = var.namespace

  advertise_on_public_default_vip = true
  disable_api_definition          = true
  no_challenge                    = true
  disable_ddos_detection          = true

  #domains = ["${var.name}.${var.delegated_dns_domain}"]
  domains = ["${var.dns_domain}"]

  #round_robin = true
  source_ip_stickiness = true

  https_auto_cert {
    http_redirect = true
    add_hsts      = false
    port          = 443
    tls_config {
      default_security = true
    }
    no_mtls = true
  }

  enable_malicious_user_detection = true
  service_policies_from_namespace = true
  disable_trust_client_ip_headers = true
  user_id_client_ip               = true

  app_firewall {
    name      = "${var.name}-waap"
    namespace = var.namespace
  }

  enable_ip_reputation {
    ip_threat_categories = ["SPAM_SOURCES"]
  }

  cors_policy {
    allow_origin = [
      "raw.githubusercontent.com"
    ]
    allow_origin_regex = []
    allow_methods      = "GET"
  }

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
        host_redirect     = "${var.name}.${var.dns_domain}"
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
        host_redirect     = "${var.name}.${var.dns_domain}"
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
        host_redirect     = "${var.name}.${var.dns_domain}"
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
          name      = volterra_origin_pool.origin.name
        }
        weight   = 1
        priority = 1
      }
      host_rewrite = "coleman.myedgedemo.com"
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
          name      = volterra_origin_pool.origin.name
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
        host_redirect     = "${var.name}.${var.dns_domain}"
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
          name      = volterra_origin_pool.origin.name
        }
        weight   = 1
        priority = 1
      }
    }
  }

  routes {
    simple_route {
      http_method = "GET"
      path {
        regex = ".*(.jpg|.png|.gif)"
      }
      origin_pools {
        pool {
          namespace = var.namespace
          name      = volterra_origin_pool.origin.name
        }
        weight   = 1
        priority = 1
      }
    }
  }

}
