
resource "kubernetes_namespace" "metallb-system" {
  metadata {
    annotations = {
      name = "metallb"
    }

    labels = {
      "pod-security.kubernetes.io/enforce" = "privileged"
      "pod-security.kubernetes.io/audit" = "privileged"
      "pod-security.kubernetes.io/warn" = "privileged"
    }

    name = "metallb-system"
  }
}