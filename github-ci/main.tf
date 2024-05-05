
resource "kubernetes_secret_v1" "github-creds" {
    metadata {
      name = "github-creds"
      namespace = "argo-events"
      # namespace = "argo"

    }
  
    data = {
        sshprivatekey = file("github_rsa")
        user = "jack@lightup.tw"
        password = "00Sa!2qwxz"
    }
}

resource "kubernetes_secret_v1" "kaniko-secret" {
    metadata {
      name = "kaniko-secret"
      namespace = "argo-events"
      # namespace = "argo"

    }
  
    data = {
        "kaniko-secret.json" = file("kaniko-secret.json")
    }
}

variable "slack-token" {
  type = string
}

resource "kubernetes_secret_v1" "slack-secret" {
    metadata {
      name = "slack-secret"
      namespace = "argo-events"
    }
  
    data = {
        "token" = var.slack-token
    }
}

# kubectl create secret generic kaniko-secret --from-file=./kaniko-secret.json