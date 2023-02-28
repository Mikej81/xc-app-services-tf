
resource "volterra_origin_pool" "tcp_origin" {
  name      = "${var.name}-tcp-origin"
  namespace = var.namespace

  endpoint_selection     = "LOCAL_PREFERRED"
  loadbalancer_algorithm = "LB_OVERRIDE"

  origin_servers {

    public_name {
      dns_name = "coleman.myedgedemo.com"
    }

    labels = {
      "key1" = "value1"
    }
  }
  port = 22

  use_tls {
    use_host_header_as_sni = true
    tls_config {
      default_security = true
    }
    skip_server_verification = true
    no_mtls                  = true
  }
}

resource "random_pet" "tcp_loadbalancer" {
  #count  = var.lb_count
  length = 2
}

resource "volterra_tcp_loadbalancer" "tcpProxy" {
  depends_on = [
    volterra_origin_pool.tcp_origin
  ]
  #count     = var.lb_count
  name      = "${var.name}-${random_pet.tcp_loadbalancer.id}-tcp-lb"
  namespace = var.namespace

  advertise_on_public_default_vip         = true
  no_sni                                  = true
  dns_volterra_managed                    = true
  hash_policy_choice_source_ip_stickiness = true
  do_not_retract_cluster                  = true

  domains = ["${random_pet.tcp_loadbalancer.id}.${var.delegated_dns_domain}"]

  listen_port = 2222

  origin_pools_weights {
    pool {
      namespace = var.namespace
      name      = "${var.name}-tcp-origin"
    }
    weight   = 1
    priority = 1
  }
}
