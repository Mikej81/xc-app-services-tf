resource "volterra_app_firewall" "example" {
  name      = "${var.name}-waap"
  namespace = var.namespace
  labels = {
    "ves.io/app_type" = "${var.name}-app-type"
  }

  blocking                   = true
  default_detection_settings = true
  default_bot_setting        = true
  allow_all_response_codes   = true
  default_anonymization      = true

  use_default_blocking_page = true

}
