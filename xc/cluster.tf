# resource "volterra_cluster" "cluster" {
#   name      = "${var.name}-cluster"
#   namespace = var.namespace

#   endpoints {
#     namespace = var.namespace
#     name      = "${var.name}-custom-route"
#   }
#   tls_parameters {
#     #use_host_header_as_sni = true
#   }
#   auto_http_config = true
# }
