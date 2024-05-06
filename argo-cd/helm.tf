resource "helm_release" "argo-cd-helm" {
  name       = "argo-cd"
  namespace  = "argo-cd"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

  values = [
    file("${path.module}/values.yaml")
  ]

  # depends_on = [  ]
}

resource "kubernetes_namespace" "argo-cd-ns" {
  metadata {
    name = "argo-cd"
  }
}
