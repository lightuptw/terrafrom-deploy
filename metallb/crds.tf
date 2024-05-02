resource "kubectl_manifest" "BGPPeer" {
  yaml_body = file("crds/bgpper.yaml")
}

resource "kubectl_manifest" "IPAddressPool" {
  yaml_body = file("crds/iPAddressPool.yaml")
}

resource "kubectl_manifest" "BGPAdvertisement" {
  yaml_body = file("crds/bGPAdvertisement.yaml")
}


# resource "kubernetes_manifest" "IPAddressPool" {
#   manifest = {
#     apiVersion = "metallb.io/v1beta1"
#     kind       = "IPAddressPool"

#     metadata = {
#       name = "first-pool"
#       namespace = "metallb-system"
#     }

#     spec = {
#         addresses = [
#             "192.168.0.150/32"
#         ]

#     }
#   }
# }

# resource "kubernetes_manifest" "L2Advertisement" {
#   manifest = {
#     apiVersion = "metallb.io/v1beta1"
#     kind       = "L2Advertisement"

#     metadata = {
#       name = "example"
#       namespace = "metallb-system"
#     }

#     spec = {
#         ipAddressPools = [
#             "first-pool"
#         ]

#     }
#   }
# }

