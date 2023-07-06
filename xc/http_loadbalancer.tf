data "volterra_namespace" "existing_namespace" {
  name = var.namespace
}

resource "volterra_namespace" "namespace" {
  depends_on = [data.volterra_namespace.existing_namespace]
  count      = 1 - signum(length(data.volterra_namespace.existing_namespace.id))
  name       = var.namespace
}

# added timer to give the LB time to generate the challenge values
resource "time_sleep" "wait_15_seconds" {
  depends_on      = [volterra_namespace.namespace]
  create_duration = "15s"
}

resource "volterra_origin_pool" "origin" {
  depends_on = [volterra_namespace.namespace, time_sleep.wait_15_seconds]
  #depends_on = [time_sleep.wait_15_seconds]
  name      = "${var.name}-origin"
  namespace = var.namespace

  endpoint_selection     = "LOCAL_PREFERRED"
  loadbalancer_algorithm = "LB_OVERRIDE"

  origin_servers {

    public_name {
      dns_name = var.origin_destination
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

  # advanced_options {
  #   http1_config = true
  # }
}

resource "volterra_http_loadbalancer" "app_proxy" {
  depends_on = [volterra_namespace.namespace, time_sleep.wait_15_seconds]
  #depends_on = [time_sleep.wait_15_seconds]
  name      = "${var.name}-http-lb"
  namespace = var.namespace

  advertise_on_public_default_vip = true
  disable_api_definition          = true
  no_challenge                    = true
  disable_ddos_detection          = true

  domains = ["${var.dns_domain}"]

  round_robin = true
  #source_ip_stickiness = true

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

  routes {
    simple_route {
      http_method = "ANY"
      path {
        prefix = "/"
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

# added timer to give the LB time to generate the challenge values
resource "time_sleep" "wait_15_seconds_again" {
  depends_on      = [volterra_namespace.namespace, volterra_http_loadbalancer.app_proxy]
  create_duration = "15s"
}

data "volterra_http_loadbalancer_state" "lb_output" {
  depends_on = [volterra_namespace.namespace, volterra_http_loadbalancer.app_proxy, time_sleep.wait_15_seconds_again]
  namespace  = var.namespace
  name       = volterra_http_loadbalancer.app_proxy.name

}

output "lb_ip_address" {
  depends_on = [data.volterra_http_loadbalancer_state.lb_output]
  value      = data.volterra_http_loadbalancer_state.lb_output.ip_address
}

output "challenge_name" {
  depends_on = [data.volterra_http_loadbalancer_state.lb_output]
  value      = flatten(data.volterra_http_loadbalancer_state.lb_output.auto_cert_info[*].dns_records[*].name)[0]
}

output "challenge_value" {
  depends_on = [data.volterra_http_loadbalancer_state.lb_output]
  value      = flatten(data.volterra_http_loadbalancer_state.lb_output.auto_cert_info[*].dns_records[*].value)[0]
}
