resource "kubectl_manifest" "GatewayClass" {
  yaml_body  = <<-EOF
    apiVersion: gateway.networking.k8s.io/v1
    kind: GatewayClass
    metadata:
      name: eg
    spec:
      controllerName: gateway.envoyproxy.io/gatewayclass-controller
    EOF
}

resource "kubectl_manifest" "Gateway" {
  yaml_body  = <<-EOF
    apiVersion: gateway.networking.k8s.io/v1
    kind: Gateway
    metadata:
      name: eg
    spec:
      gatewayClassName: eg
      listeners:
        - name: http
          allowedRoutes:
                namespaces:
                  from: All        
          protocol: HTTP
          port: 80
        - name: tcp
          protocol: TCP
          port: 8089
          allowedRoutes:
            kinds:
            - kind: TCPRoute          
  EOF
}

# resource "kubectl_manifest" "ServiceAccount" {
#   yaml_body  = <<-EOF
#     apiVersion: v1
#     kind: ServiceAccount
#     metadata:
#       name: backend
#   EOF
# }
