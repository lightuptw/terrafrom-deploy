locals{
  route = yamldecode(file("route.yaml"))
}

# variable hostname {
#   type = string
# }

# resource "kubectl_manifest" "HTTPRoute" {
#   yaml_body  = yamlencode({
#     apiVersion = lookup(local.route, "apiVersion")
#     kind = lookup(local.route, "kind")
#     metadata = lookup(local.route, "metadata")
#     # spec = merge(lookup(local.route, "spec"), {
#     #   hostnames = ["${var.hostname}"]
#     # }) 
#     spec = lookup(local.route, "spec")
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
#     namespace: envoy-gateway
#   to:
#   - group: ""
#     kind: Service
#     EOF
# }
