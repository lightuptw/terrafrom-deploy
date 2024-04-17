terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
  
  registry {
    url = "oci://docker.io/envoyproxy/gateway-helm"
    username = ""
    password = ""
  }

}

provider "kubernetes" {
  config_path = "~/.kube/config"
}