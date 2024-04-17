resource "kubernetes_resource" "Gateway" {
  manifest = {
    apiVersion = "gateway.networking.k8s.io/v1"
    kind       = "Gateway"

    metadata = {
      name = "eg"
      namespace = "envory-gateway-system"
    }

    spec = {
        controllerNam = "gateway.envoyproxy.io/gatewayclass-controller"
    }
  }
}

# resource "kubernetes_manifest" "GatewayClass" {
#   manifest = {
#     apiVersion = "gateway.networking.k8s.io/v1"
#     kind       = "GatewayClass"

#     metadata = {
#       name = "eg"
#     }

#     spec = {
#         gatewayClassName = "eg"
#         listeners = [
#             {
#                 name = "http"
#                 protocol = "HTTP"
#                 port = "80"
#             }
#         ]
#     }
#   }
# }

# resource "kubernetes_manifest" "ServiceAccount" {
#   manifest = {
#     apiVersion = "v1"
#     kind       = "ServiceAccount"

#     metadata = {
#       name = "backend"
#       namespace = "envory-gateway-system"
#     }
#   }
# }

