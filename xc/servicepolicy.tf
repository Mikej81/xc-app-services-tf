resource "volterra_service_policy" "coleman-policy" {
  name      = "coleman-web"
  namespace = var.namespace

  algo = "FIRST_MATCH"

  allow_list {
    asn_list {
      as_numbers = [
        713,
        7932,
        847325,
        4683,
        15269,
        1000001
      ]
    }

    asn_set {
      name      = "test1"
      namespace = var.namespace
    }

    // One of the arguments from this list "default_action_next_policy default_action_deny default_action_allow" must be set
    default_action_next_policy = true

    prefix_list {
      prefixes = ["192.168.20.0/24"]
    }

    //tls_fingerprint_classes = ["tls_fingerprint_classes"]

    //tls_fingerprint_values = ["tls_fingerprint_values"]
  }
  // One of the arguments from this list "any_server server_name server_selector server_name_matcher" must be set
  any_server = true
}
