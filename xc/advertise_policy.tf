resource "volterra_advertise_policy" "udp-advertise" {
  name      = "${var.name}-udp-advertise"
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
  protocol = "UDP"
  port     = 5553
}
