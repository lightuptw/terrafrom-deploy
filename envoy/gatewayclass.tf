resource "kubectl_manifest" "GatewayClass" {
  yaml_body = file("gatewayClassDeploy.yaml")

  depends_on = [ helm_release.eg ]
}

resource "kubectl_manifest" "Gateway" {
  yaml_body = (file("gateway.yaml"))
}

resource "kubectl_manifest" "EnvoyProxy" {
  yaml_body = (file("envoyProxyDeploy.yaml"))

  depends_on = [ helm_release.eg ]
}
