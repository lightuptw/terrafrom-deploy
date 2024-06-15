resource "helm_release" "cnpg" {
  name       = "cnpg"
  namespace  = "cnpg-system"
  repository = "https://cloudnative-pg.github.io/charts"
  chart = "cloudnative-pg"
  version = "v0.21.5"
  values = [
    file("${path.module}/values.yaml")
  ]

#   set {
#     name = "namespace"
#     value = "cnpg-system"
#   }


  depends_on = [ kubernetes_namespace.cnpg-system-ns ]
}

resource "kubernetes_namespace" "cnpg-system-ns" {
  metadata {
    annotations = {
      name = "cnpg-system"
    }
    name = "cnpg-system"
  }
}


# resource "kubectl_manifest" "app_guestbook" {
#   yaml_body = <<-EOF
#     apiVersion: argoproj.io/v1alpha1
#     kind: Application
#     metadata:
#         name: postgres
#         namespace: argo-cd
#     spec:
#         project: postgres
#         source:
#             repoURL: git@github.com:lightuptw/deploy.git
#             targetRevision: HEAD
#             path: postgres
#         destination:
#             server: https://kubernetes.default.svc
#             namespace: cnpg-system
#     EOF

# }