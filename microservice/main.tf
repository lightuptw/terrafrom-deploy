# resource "kubectl_manifest" "apps" {
#     yaml_body = file("${path.module}/appSet.yaml")
# }

resource "kubectl_manifest" "kratos_tanant" {
    yaml_body = file("${path.module}/kratosSet.yaml")
}