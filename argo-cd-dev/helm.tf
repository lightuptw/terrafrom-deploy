resource "helm_release" "argo-cd-helm" {
  name       = "argo-cd"
  namespace  = "argo-cd"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

  values = [
    file("${path.module}/values.yaml")
  ]

  create_namespace = true

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

resource "kubernetes_secret" "helm_oci_secret" {
  metadata {
    name = "docker-io-helm-oci"
    namespace = "argo-cd"
    labels = {
       "app.kubernetes.io/part-of" = "argocd"
       "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  binary_data = {
    "url" =  base64encode("registry-1.docker.io/bitnamicharts")
    "name" = base64encode("bitnamicharts")
    "type" = base64encode("helm")
    "enableOCI" = base64encode("true")
  }
  
}

