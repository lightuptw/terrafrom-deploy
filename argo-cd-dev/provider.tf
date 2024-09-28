terraform {
  backend "gcs" {
    bucket = "tofu_state_lightup"
    # region = "asia-east-1"
    prefix  = "state/argo-cd-local-dev"
  }

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
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "kubectl" {
  config_path = "~/.kube/config"
}