resource "kubernetes_secret" "microservices_repo_secret" {
  metadata {
    name = "microservices-repo-secret"
    namespace = "argo-cd"
    annotations = {
        "managed-by": "argocd.argoproj.io"
    }
    labels = {
        "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  binary_data = {
    "name" = base64encode("microservices") 
    "project" = base64encode("microservices") 
    "typs" =  base64encode("git") 
    "url" = base64encode("git@github.com:lightuptw/microservices-deploy.git")
    "sshPrivateKey" = base64encode(file("${path.module}/microservices-repo"))
  }
}

resource "kubernetes_secret" "uaa_repo_secret" {
  metadata {
    name = "uaa-repo-secret"
    namespace = "argo-cd"
    annotations = {
        "managed-by": "argocd.argoproj.io"
    }
    labels = {
        "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  binary_data = {
    "name" = base64encode("uaa") 
    "project" = base64encode("uaa") 
    "typs" =  base64encode("git") 
    "url" = base64encode("git@github.com:lightuptw/uaa-deploy.git")
    "sshPrivateKey" = base64encode(file("${path.module}/uaa-repo"))
  }
}

resource "kubernetes_secret" "infrastructure_repo_secret" {
  metadata {
    name = "infrastructure-repo-secret"
    namespace = "argo-cd"
    annotations = {
        "managed-by": "argocd.argoproj.io"
    }
    labels = {
        "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  binary_data = {
    "name" = base64encode("infrastructure") 
    "project" = base64encode("infrastructure") 
    "typs" =  base64encode("git") 
    "url" = base64encode("git@github.com:lightuptw/infrastructure-deploy.git")
    "sshPrivateKey" = base64encode(file("${path.module}/infrastructure-repo"))
  }
  
}
