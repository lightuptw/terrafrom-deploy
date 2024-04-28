resource "kubectl_manifest" "HTTPRoute" {
  yaml_body  = <<-EOF
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: argowfr
  namespace: default
spec:
  parentRefs:
    - name: eg
  hostnames:
    - "argo-workflows.s.net-chain.xyz"
  rules:
    - backendRefs:
        - group: ""
          kind: Service
          namespace: argo
          name: argo-workflows-server
          port: 80
          weight: 1
      matches:
        - path:
            type: PathPrefix
            value: /
    EOF
}

resource "kubectl_manifest" "ReferenceGrant" {
  yaml_body  = <<-EOF
apiVersion: gateway.networking.k8s.io/v1beta1
kind: ReferenceGrant
metadata:
  name: argorg
  namespace: argo
spec:
  from:
  - group: gateway.networking.k8s.io
    kind: HTTPRoute
    namespace: default
  to:
  - group: ""
    kind: Service
    EOF
}



# resource "kubectl_manifest" "HTTPRoute" {
#   yaml_body  = <<-EOF

# kind: ReferenceGrant
# metadata:
#   name: bar
#   namespace: bar
# spec:
#   from:
#   - group: gateway.networking.k8s.io
#     kind: HTTPRoute
#     namespace: foo
#   to:
#   - group: ""
#     kind: Service

#     EOF
# }

# resource "kubectl_manifest" "TCPRoute" {
#   yaml_body  = <<-EOF
# apiVersion: gateway.networking.k8s.io/v1alpha2
# kind: TCPRoute
# metadata:
#   name: argo-workflows-server
# spec:
#   parentRefs:
#     - name: eg
#   hostnames:
#     - "argo-workflows.s.net-chain.xyz"
#   rules:
#     - backendRefs:
#         - group: ""
#           name: tcp
#           kind: Service
#           name: argo-workflows-server
#           port: 80
#           weight: 1
#       matches:
#         - path:
#             type: PathPrefix
#             value: /
#     EOF
# }