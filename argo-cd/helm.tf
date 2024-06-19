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

resource "kubernetes_secret" "oidc_secret" {
  metadata {
    name = "dex"
    namespace = "argo-cd"
    labels = {
       "app.kubernetes.io/part-of" = "argocd"
    }
  }

  data = {
    "clientId" = var.odic_clientId 
    "clientSecret" = var.oidc_secret
    "issuer" = var.odic_issuer
    "redirect_uri" = var.odic_redirect_uri
  }
  
}

