resource "helm_release" "argo-workflows-helm" {
  name       = "argo-workflows"
  namespace  = "argo"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "argo-workflows"

  values = [
    file("${path.module}/values.yaml")
  ]
}