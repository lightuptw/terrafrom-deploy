terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

variable host {
  type        = string
  default     = ""
  description = "description"
}

variable "client_certificate" {
  type = string
}

variable "client_key" {
  type = string
}

variable "cluster_ca_certificate" {
  type = string
}

provider "kubernetes" {
  host = var.host

  client_certificate     = base64decode(var.client_certificate)
  client_key             = base64decode(var.client_key)
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}

# resource "kubernetes_deployment" "nginx" {
#   metadata {
#     name = "scalable-nginx-example"
#     labels = {
#       App = "ScalableNginxExample"
#     }
#   }

#   spec {
#     replicas = 2
#     selector {
#       match_labels = {
#         App = "ScalableNginxExample"
#       }
#     }
#     template {
#       metadata {
#         labels = {
#           App = "ScalableNginxExample"
#         }
#       }
#       spec {
#         container {
#           image = "nginx:1.7.8"
#           name  = "example"

#           port {
#             container_port = 80
#           }

#           resources {
#             limits = {
#               cpu    = "0.5"
#               memory = "512Mi"
#             }
#             requests = {
#               cpu    = "250m"
#               memory = "50Mi"
#             }
#           }
#         }
#       }
#     }
#   }
# }
resource "kubernetes_service" "example" {
  metadata {
    name = "terraform-example"
  }
  spec {
    selector = {
      app = kubernetes_pod.example.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port        = 8080
      target_port = 80
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_pod" "example" {
  metadata {
    name = "terraform-example"
    labels = {
      app = "MyApp"
    }
  }

  spec {
    container {
      image = "nginx:1.21.6"
      name  = "example"
    }
  }
}