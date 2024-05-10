# kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.26/deploy/local-path-storage.yaml

resource "kubernetes_persistent_volume" "pv" {
  metadata {
    name = "ci-pv"
  }
  spec {
    capacity = {
      storage = "10Gi"
    }
    access_modes = ["ReadWriteOnce"]
    persistent_volume_source {
        local {
          path = "/mnt/ci"
        }
    }
    persistent_volume_reclaim_policy = "Retain"

    storage_class_name = "ci"

    node_affinity {
      required {
        node_selector_term {
          match_expressions {
            key = "local-pv"
            operator = "In"
            values = ["1"]
          }
        }
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "pv-cache" {
  metadata {
    name = "pv-cache"
    namespace = "argo-events"
  }

  spec {
    access_modes = ["ReadWriteOnce"]
    storage_class_name = kubernetes_persistent_volume.pv.spec[0].storage_class_name

    resources {
      requests = {
        storage = "10Gi"
      }
    }
    volume_name = "${kubernetes_persistent_volume.pv.metadata.0.name}"
  }
}
