resource "volterra_app_type" "app-type" {
  name      = "${var.name}-app-type"
  namespace = "shared"
}
