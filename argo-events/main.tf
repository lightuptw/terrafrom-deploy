resource "kubectl_manifest" "eventBus" {
  override_namespace = "argo-events"
  yaml_body = file("eventBus.yaml")
}

resource "kubectl_manifest" "eventSource" {
  override_namespace = "argo-events"
  
  yaml_body = file("eventStouce.yaml")
}

resource "kubectl_manifest" "sensor" {
  override_namespace = "argo-events"
  
  yaml_body = file("sensor.yaml")
}

resource "kubectl_manifest" "workflow-rbac" {
  override_namespace = "argo-events"

  yaml_body = file("workflow-rbac.yaml")
}

resource "kubectl_manifest" "sensor-rbac" {
  override_namespace = "argo-events"

  yaml_body = file("sensor-rbac.yaml")
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
