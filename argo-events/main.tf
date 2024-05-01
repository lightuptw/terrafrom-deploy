resource "kubectl_manifest" "eventBus" {
  override_namespace = "argo-events"
  yaml_body = file("k8s-resource/eventBus.yaml")
}

resource "kubectl_manifest" "eventSource" {
  override_namespace = "argo-events"
  
  yaml_body = file("k8s-resource/eventStouce.yaml")
}

resource "kubectl_manifest" "sensor" {
  override_namespace = "argo-events"
  
  yaml_body = file("sensor/sensor.yaml")
}

resource "kubectl_manifest" "workflow-rbac-role" {
  override_namespace = "argo-events"

  yaml_body = file("k8s-resource/workflow-rbac-role.yaml")
}

resource "kubectl_manifest" "workflow-rbac-roleBinding" {
  override_namespace = "argo-events"

  yaml_body = file("k8s-resource/workflow-rbac-roleBinding.yaml")
}
// sensor
resource "kubectl_manifest" "sensor-rbac-sa" {
  override_namespace = "argo-events"

  yaml_body = file("sensor/sensor-rbac-sa.yaml")
}

resource "kubectl_manifest" "sensor-rbac-role" {
  override_namespace = "argo-events"

  yaml_body = file("sensor/sensor-rbac-role.yaml")
}

resource "kubectl_manifest" "sensor-rbac-roleBinding" {
  override_namespace = "argo-events"

  yaml_body = file("sensor/sensor-rbac-roleBinding.yaml")
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
