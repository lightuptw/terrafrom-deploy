

resource "helm_release" "rancher" {
  name       = "rancher"
  namespace  = "cattle-system"

  repository = "https://releases.rancher.com/server-charts/stable"
  chart      = "rancher"

  values = [
    file("${path.module}/values.yaml")
  ]

  create_namespace = true

  depends_on = [ module.cert_manager ]

}

# resource "time_sleep" "wait_30_seconds" {
#   depends_on = [kubernetes_namespace.metallb-system]

#   destroy_duration = "30s"
# }