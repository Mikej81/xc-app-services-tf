resource "volterra_service_policy" "policy" {
  name      = "${var.name}-service-policy"
  namespace = var.namespace

  algo       = "FIRST_MATCH"
  any_server = true

  rule_list {
    rules {
      metadata {
        name    = "allow-prefix"
        disable = false
      }
      spec {

        action     = "ALLOW"
        any_client = true
        ip_prefix_list {
          ip_prefixes  = ["0.0.0.0/0"]
          invert_match = false
        }
        any_asn = true
        waf_action {
          none = true
        }
      }
    }
    rules {
      metadata {
        name    = "deny-header"
        disable = false
      }

      spec {
        action     = "DENY"
        any_client = true
        any_asn    = true
        headers {
          name = "Host"
          item {
            exact_values = ["domain.com"]
          }
          invert_matcher = false
        }
        waf_action {
          none = true
        }
      }
    }
    rules {
      metadata {
        name    = "deny-asn"
        disable = false
      }
      spec {
        action = "DENY"
        asn_list {
          as_numbers = [
            204791,
            205515,
            208090,
            28761,
            41269,
            43222,
            43564,
            49617,
            59744,
            8654
          ]
        }
        waf_action {
          none = true
        }
      }
    }
    rules {
      metadata {
        name    = "deny-country-list"
        disable = false
      }
      spec {
        action = "DENY"
        client_selector {
          expressions = [
            "geoip.ves.io/country in (BY, BA, BI, CF, CU, IR, IQ, KP, XK, LY, MK, SO, SD, SY, ZW,CD, LB, NI, RU,SS, VE, YE)"
          ]
        }
        waf_action {
          none = true
        }
      }
    }

    rules {
      metadata {
        name    = "deny-ip-reputation"
        disable = false
      }
      spec {
        action = "DENY"
        ip_threat_category_list {
          ip_threat_categories = [
            "SPAM_SOURCES",
            "REPUTATION",
            "PROXY",
            "TOR_PROXY",
            "DENIAL_OF_SERVICE",
            "NETWORK",
            "BOTNETS",
            "WEB_ATTACKS"
          ]
        }
        waf_action {
          none = true
        }
      }
    }
  }


}
