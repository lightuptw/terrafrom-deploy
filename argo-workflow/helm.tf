resource "helm_release" "argo-workflows-helm" {
  name       = "argo-workflows"
  namespace  = "argo"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-workflows"
  # version = "8.0.6"

  values = [
    file("${path.module}/values.yaml")
  ]
}