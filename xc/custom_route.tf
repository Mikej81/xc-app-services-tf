resource "volterra_route" "custom-route" {
  name      = "${var.name}-custom-route"
  namespace = var.namespace

  routes {
    inherited_bot_defense_javascript_injection = true

    disable_custom_script = true
    disable_location_add  = true

    match {
      http_method = "ANY"

      path {
        prefix = "/custom/"
      }
    }

    route_destination {
      destinations {
        cluster {
          namespace = var.namespace
          name      = "${var.name}-cluster"
        }
        weight   = "1"
        priority = "1"
      }

      do_not_retract_cluster = true

      cors_policy {
        allow_credentials = true
        allow_methods     = "GET"

        allow_origin = ["*"]
      }

      auto_host_rewrite = true

      prefix_rewrite = "/"
      priority       = "DEFAULT"

      spdy_config {
        use_spdy = true
      }

      timeout = "2000"

      web_socket_config {
        idle_timeout         = "2000"
        max_connect_attempts = "5"
        use_websocket        = true
      }
    }

    service_policy {

      context_extensions {
        context_extensions = {
          "ServicePolicyKey" = "ServicePolicyValue"
        }
      }
      //disable = true
    }
    skip_lb_override = true
    waf_type {

      app_firewall {
        app_firewall {
          name      = "${var.name}-waap"
          namespace = var.namespace
        }
      }
    }
  }
}
