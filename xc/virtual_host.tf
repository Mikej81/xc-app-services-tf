resource "volterra_virtual_host" "vhost" {
  namespace = var.namespace
  name      = "${var.name}-virtual-host"

  proxy = "UDP_PROXY"

  domains = []

  advertise_policies {
    namespace = var.namespace
    name      = volterra_advertise_policy.udp-advertise.name
  }

  waf_type {
    disable_waf = true
  }
  connection_idle_timeout = 0

  slow_ddos_mitigation {
    request_timeout         = 60000
    request_headers_timeout = 10000
  }
}
