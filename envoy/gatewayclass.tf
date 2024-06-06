resource "kubectl_manifest" "GatewayClass" {
  yaml_body = file("gatewayClass.yaml")
}

resource "kubectl_manifest" "Gateway" {
  yaml_body = (file("gateway.yaml"))
}

resource "kubectl_manifest" "EnvoyProxy" {
  yaml_body = (file("envoyProxy.yaml"))
}
