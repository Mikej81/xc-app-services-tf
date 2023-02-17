resource "volterra_app_setting" "app-setting" {
  name      = "${var.name}-app-setting"
  namespace = var.namespace

  app_type_settings {
    app_type_ref {
      name      = "${var.name}-app-type"
      namespace = "shared"
    }

    business_logic_markup_setting {
      enable = true
    }

    timeseries_analyses_setting {
      metric_selectors {
        metric = [
          "ERROR_RATE",
          "THROUGHPUT",
          "REQUEST_RATE"
        ]
        metrics_source = "VIRTUAL_HOSTS"
      }
    }

    user_behavior_analysis_setting {
      enable_learning = true

      enable_detection {

        include_failed_login_activity {
          login_failures_threshold = "10"
        }
        include_forbidden_activity {
          forbidden_requests_threshold = "10"
        }
        include_ip_reputation = true
        include_non_existent_url_activity_automatic {
          medium = true
        }
        include_waf_activity = true
        cooling_off_period   = "20"
      }
    }
  }
}
