resource "kubectl_manifest" "Gateway" {
  yaml_body = <<-EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-cm
  namespace: argo-cd
  labels:
    app.kubernetes.io/name: argocd-cm
    app.kubernetes.io/part-of: argocd
data:
  # add an additional local user with apiKey and login capabilities
  #   apiKey - allows generating API keys
  #   login - allows to login using UI
  accounts.deployer: apiKey
  # disables user. User is enabled by default
  accounts.deployer.enabled: "true"
  EOF
}

