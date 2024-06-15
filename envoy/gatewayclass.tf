resource "kubectl_manifest" "GatewayClass" {
  yaml_body = file("gatewayClass.yaml")

  depends_on = [ helm_release.eg ]
}

resource "kubectl_manifest" "Gateway" {
  yaml_body = (file("gateway.yaml"))
}

resource "kubectl_manifest" "EnvoyProxy" {
  yaml_body = (file("envoyProxy.yaml"))

  depends_on = [ helm_release.eg ]
}
