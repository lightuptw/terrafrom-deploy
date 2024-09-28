# locals{
#   route = yamldecode(file("route.yaml"))
# }

# variable hostname {
#   type = string
# }

# resource "kubectl_manifest" "HTTPRoute" {
#   yaml_body  = yamlencode({
#     apiVersion = lookup(local.route, "apiVersion")
#     kind = lookup(local.route, "kind")
#     metadata = lookup(local.route, "metadata")
#     spec = merge(lookup(local.route, "spec"), {
#       hostnames = ["${var.hostname}"]
#     }) 
#   })
# }

# resource "kubectl_manifest" "ReferenceGrant" {
#   yaml_body  = <<-EOF
# apiVersion: gateway.networking.k8s.io/v1beta1
# kind: ReferenceGrant
# metadata:
#   name: argo-cd-rg
#   namespace: argo-cd
# spec:
#   from:
#   - group: gateway.networking.k8s.io
#     kind: HTTPRoute
#     namespace: default
#   to:
#   - group: ""
#     kind: Service
#     EOF
# }



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