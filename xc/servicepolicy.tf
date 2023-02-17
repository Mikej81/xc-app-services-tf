resource "volterra_service_policy" "coleman-policy" {
  name      = "${var.name}-service-policy"
  namespace = var.namespace

  algo = "FIRST_MATCH"

  allow_list {


    // One of the arguments from this list "default_action_next_policy default_action_deny default_action_allow" must be set
    default_action_next_policy = true

    prefix_list {
      prefixes = ["192.168.20.0/24"]
    }

    //tls_fingerprint_classes = ["tls_fingerprint_classes"]

    //tls_fingerprint_values = ["tls_fingerprint_values"]
  }
  deny_list {
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
    country_list = [
      "COUNTRY_BY",
      "COUNTRY_BA",
      "COUNTRY_BI",
      "COUNTRY_CF",
      "COUNTRY_CU",
      "COUNTRY_IR",
      "COUNTRY_IQ",
      "COUNTRY_KP",
      "COUNTRY_XK",
      "COUNTRY_LY",
      "COUNTRY_MK",
      "COUNTRY_SO",
      "COUNTRY_SD",
      "COUNTRY_SY",
      "COUNTRY_ZW",
      "COUNTRY_CD",
      "COUNTRY_LB",
      "COUNTRY_NI",
      "COUNTRY_RU",
      "COUNTRY_SS",
      "COUNTRY_VE",
      "COUNTRY_YE"
    ]
  }

  any_server = true
}
