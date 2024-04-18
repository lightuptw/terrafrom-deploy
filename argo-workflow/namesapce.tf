resource "kubernetes_namespace" "argo-ns" {
  metadata {
    annotations = {
      name = "argo"
    }
    name = "argo"
  }
}