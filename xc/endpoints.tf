resource "volterra_endpoint" "endpoints" {
  name      = "${var.name}-endpoint"
  namespace = var.namespace

  where {
    virtual_network {
      ref {
        tenant    = "ves-io"
        namespace = "shared"
        name      = "public"
      }
    }
  }
  protocol = "TCP"
  port     = "443"
  dns_name = "coleman.myedgedemo.com"
}
