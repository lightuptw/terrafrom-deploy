resource "helm_release" "argo-events-helm" {
  name       = "argo-events"
  namespace  = "argo-events"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-events"

  # values = [
  #   file("${path.module}/values.yaml")
  # ]
}