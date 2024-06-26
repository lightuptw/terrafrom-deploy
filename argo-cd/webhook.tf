resource "kubernetes_secret" "webhook_secret" {
  metadata {
    name = "argocd-webhook-secret"
    namespace = "argo-cd"
    labels = {
       "app.kubernetes.io/part-of" = "argocd"
    }
  }

  binary_data = {
    "webhook.github.secret" = base64encode(var.github_webhook_secret) 
  }
  
}
