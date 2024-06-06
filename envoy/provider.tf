terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }

    kubectl = {
      source = "gavinbunney/kubectl"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
  
  # registry {
  #   url = "oci://docker.io/envoyproxy/gateway-helm"
  #   username = ""
  #   password = ""
  # }

}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "kubectl" {
  config_path = "~/.kube/config"
}



# resource "google_container_cluster" "cluster" {
#   project  = "lightup-tw"
#   name     ="lightup-ms-cluster"
#   location = "asia-east1"

#   remove_default_node_pool = true
#   initial_node_count       = 1
# }

# data "google_client_config" "current" {}

# provider "helm" {
#   kubernetes {
#     host                   = "https://${google_container_cluster.cluster.endpoint}"
#     cluster_ca_certificate = base64decode(google_container_cluster.cluster.master_auth.0.cluster_ca_certificate)
#     token                  = data.google_client_config.current.access_token
#   }
  
#   # registry {
#   #   url = "oci://docker.io/envoyproxy/gateway-helm"
#   #   username = "saqwxz06@gmail.com"
#   #   password = "saqwxz12"
#   # }

# }



# provider "kubernetes" {
#   host                   = "https://${google_container_cluster.cluster.endpoint}"
#   cluster_ca_certificate = base64decode(google_container_cluster.cluster.master_auth.0.cluster_ca_certificate)
#   token                  = data.google_client_config.current.access_token
# }

# provider "kubectl" {
#   host                   = "https://${google_container_cluster.cluster.endpoint}"
#   cluster_ca_certificate = base64decode(google_container_cluster.cluster.master_auth.0.cluster_ca_certificate)
#   token                  = data.google_client_config.current.access_token
#   load_config_file       = false
# }