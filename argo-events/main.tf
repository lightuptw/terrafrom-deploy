resource "kubectl_manifest" "eventBus" {
  override_namespace = "argo-events"
  yaml_body = file("k8s-resource/eventBus.yaml")

  depends_on = [helm_release.argo-events-helm]
}

locals {
  es = yamldecode(file("k8s-resource/eventSource.yaml"))
}

variable "repo-owner" {
  type = string
}

variable "repo-names" {
  type = list(string)
}

variable "event-name" {
  default = "example"
}

resource "kubectl_manifest" "eventSource" {
  override_namespace = "argo-events"
  
  yaml_body  = yamlencode({
    apiVersion = lookup(local.es, "apiVersion")
    kind = lookup(local.es, "kind")
    metadata = lookup(local.es, "metadata")
    spec = merge(lookup(local.es, "spec"), {
      github = {
        "${var.event-name}" = {
          repositories = [
            {
              owner = var.repo-owner
              names = var.repo-names
            }
          ]
          webhook = {
            endpoint = "/push"
            port = "12000"
            method = "POST"
            url = "https://${var.hostname}"
          }
          events = ["push"]
          apiToken = {
            name = "github-access"
            key = "token"
          }
          webhookSecret = {
            name = "github-access"
            key = "secret"
          }
          insecure = true
          active = true
          contentType = "json"
        }
      }
    }) 
  })
  depends_on = [helm_release.argo-events-helm]

}

resource "kubectl_manifest" "sensor" {
  override_namespace = "argo-events"
  
  yaml_body = file("sensor/sensor.yaml")
  depends_on = [helm_release.argo-events-helm]

}

resource "kubectl_manifest" "ci-wft" {
  override_namespace = "argo-events"
  
  yaml_body = file("sensor/ci-wft.yaml")
  depends_on = [helm_release.argo-events-helm]
}


resource "kubectl_manifest" "workflow-rbac-role" {
  override_namespace = "argo-events"

  yaml_body = file("k8s-resource/workflow-rbac-role.yaml")
  depends_on = [helm_release.argo-events-helm]

}

resource "kubectl_manifest" "workflow-rbac-roleBinding" {
  override_namespace = "argo-events"

  yaml_body = file("k8s-resource/workflow-rbac-roleBinding.yaml")
  depends_on = [helm_release.argo-events-helm]

}
// sensor
resource "kubectl_manifest" "sensor-rbac-sa" {
  override_namespace = "argo-events"

  yaml_body = file("sensor/sensor-rbac-sa.yaml")
  depends_on = [helm_release.argo-events-helm]

}

resource "kubectl_manifest" "sensor-rbac-role" {
  override_namespace = "argo-events"

  yaml_body = file("sensor/sensor-rbac-role.yaml")
  depends_on = [helm_release.argo-events-helm]

}

resource "kubectl_manifest" "sensor-rbac-roleBinding" {
  override_namespace = "argo-events"

  yaml_body = file("sensor/sensor-rbac-roleBinding.yaml")
  depends_on = [helm_release.argo-events-helm]

}

variable "github-access-token" {
  type = string
}

variable "github-access-secret" {
  type = string
}

resource "kubectl_manifest" "cloudflare-api-key-secret" {
  override_namespace = "argo-events"

    yaml_body = yamlencode({
        apiVersion = "v1"
        kind = "Secret"
        metadata = {
            name = "github-access"
        }
        type = "Opaque"
        stringData = {
            token = var.github-access-token
            secret = var.github-access-secret
        }
    })
#   yaml_body  = <<EOF
# apiVersion: v1
# kind: Secret
# metadata:
#   namespace: cert-manager
#   name: cloudflare-api-key-secret
# type: Opaque
# stringData:
#   api-key: "tfMyI_weJW_-HEfghh7fAg4Ck6tNbpcp3zwhrwSy"
# EOF
}
