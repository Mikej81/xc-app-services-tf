resource "volterra_app_firewall" "example" {
  depends_on = [volterra_namespace.namespace]
  name       = "${var.name}-waap"
  namespace  = var.namespace

  blocking                   = true
  default_detection_settings = true
  default_bot_setting        = true
  allow_all_response_codes   = true
  default_anonymization      = true

  use_default_blocking_page = true

}
