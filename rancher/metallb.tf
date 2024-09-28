
resource "helm_release" "metallb" {
  name       = "metallb"
  namespace  = "metallb-system"

  repository = "https://metallb.github.io/metallb"
  chart      = "metallb"

  create_namespace = true

  values = [
    file("${path.module}/values.yaml")
  ]
}


resource "kubernetes_manifest" "IPAddressPool" {
  manifest = {
    apiVersion = "metallb.io/v1beta1"
    kind       = "IPAddressPool"

    metadata = {
      name = "rancher-pool"
      namespace = "metallb-system"
    }

    spec = {
        addresses = [
            "10.10.2.109/32"
        ]

    }
  }

  depends_on = [ helm_release.metallb ]
}

resource "kubernetes_manifest" "L2Advertisement" {
  manifest = {
    apiVersion = "metallb.io/v1beta1"
    kind       = "L2Advertisement"

    metadata = {
      name = "rancher-l2"
      namespace = "metallb-system"
    }

    spec = {
        ipAddressPools = [
            "rancher-pool"
        ]

    }
  }

  depends_on = [ helm_release.metallb ]

}
