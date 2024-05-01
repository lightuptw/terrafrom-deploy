resource "kubernetes_namespace" "argo-events-ns" {
  metadata {
    # annotations = {
    #   name = "argo-events"
    # }
    name = "argo-events"

  }
}
