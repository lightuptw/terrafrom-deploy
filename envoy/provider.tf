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
  
  registry {
    url = "oci://docker.io/envoyproxy/gateway-helm"
    username = ""
    password = ""
  }

}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "kubectl" {
  config_path = "~/.kube/config"
}