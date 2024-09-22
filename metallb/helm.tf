

resource "helm_release" "metallb" {
  name       = "metallb"
  namespace  = "metallb-system"

  repository = "https://metallb.github.io/metallb"
  chart      = "metallb"

  values = [
    file("${path.module}/values.yaml")
  ]
}

resource "time_sleep" "wait_10_seconds" {
  depends_on = [kubernetes_namespace.metallb-system]

  destroy_duration = "10s"
}