# resource "kubectl_manifest" "microservices_project" {
#   yaml_body = templatefile(
#     "${path.module}/project.tftpl", 
#     {
#         project = "microservices"
#     }
#   )
# }

# resource "kubectl_manifest" "uaa_project" {
#   yaml_body = templatefile("${path.module}/project.tftpl", {
#     project = "uaa"
#   })
# }

# resource "kubectl_manifest" "infrastructure_project" {
#   yaml_body = templatefile("${path.module}/project.tftpl", {
#     project = "infrastructure"
#   })
# }
