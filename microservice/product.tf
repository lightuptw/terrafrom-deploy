resource "kubectl_manifest" "app_prod_product" {
    yaml_body = templatefile("${path.module}/chart.tpl", {
        app = "product",
        env = "prod"
    })
}

resource "kubectl_manifest" "app_dev_product" {
    yaml_body = templatefile("${path.module}/chart.tpl", {
        app = "product",
        env = "dev"
    })
}