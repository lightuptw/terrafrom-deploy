resource "helm_release" "eg" {
  name       = "eg"
  namespace  = "envoy-gateway-system"
  repository = "oci://docker.io/envoyproxy"
  chart = "gateway-helm"
  version = "v1.0.1"
#   values = [
#     file("${path.module}/values.yaml")
#   ]
}

# resource "time_sleep" "wait_30_seconds" {
#   depends_on = [kubernetes_namespace.envoy-gateway-system]

#   destroy_duration = "30s"
# }