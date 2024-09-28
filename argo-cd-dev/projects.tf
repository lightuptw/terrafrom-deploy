resource "kubectl_manifest" "microservices_project" {
  yaml_body = templatefile(
    "${path.module}/project.tftpl", 
    {
        project = "microservices"
    }
  )
}

# resource "kubectl_manifest" "kratos_project" {
#   yaml_body = templatefile("${path.module}/project.tftpl",  {
#     project = "kratos"
#   })
# }

# resource "kubectl_manifest" "postgres_project" {
#   yaml_body = templatefile("${path.module}/project.tftpl", {
#     project = "postgres"
#   })
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
