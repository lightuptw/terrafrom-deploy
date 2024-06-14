terraform {
  backend "gcs" {
    bucket = "tofu_state_lightup"
    prefix  = "state/gke-microservices-cluster"
  }

  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }

    kubectl = {
      source = "gavinbunney/kubectl"
    }

    google = {
      source  = "hashicorp/google"
      version = "5.5.0"
      # version = "4.62.1"
    }
  }
}
