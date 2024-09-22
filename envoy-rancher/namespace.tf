resource "kubernetes_namespace" "envoy-gateway-system" {
  metadata {
    annotations = {
      name = "envoy-gateway"
    }
    name = "envoy-gateway-system"
  }
}