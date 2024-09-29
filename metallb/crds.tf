resource "time_sleep" "wait_10_seconds_crds" {
  depends_on = [helm_release.metallb]

  destroy_duration = "10s"
}

# resource "kubectl_manifest" "IPAddressPool" {
#   yaml_body = file("crds/iPAddressPool.yaml")
#   depends_on = [helm_release.metallb, time_sleep.wait_10_seconds_crds]
# }

# resource "kubectl_manifest" "L2Advertisement" {
#   yaml_body = file("crds/l2Advertisement.yaml")
#   depends_on = [helm_release.metallb, time_sleep.wait_10_seconds_crds]
# }


// bgp
# resource "kubectl_manifest" "BGPPeer" {
#   yaml_body = file("crds/bgpper.yaml")
# }

# resource "kubectl_manifest" "BGPAdvertisement" {
#   yaml_body = file("crds/bGPAdvertisement.yaml")
# }


# resource "kubernetes_manifest" "IPAddressPool" {
#   manifest = {
#     apiVersion = "metallb.io/v1beta1"
#     kind       = "IPAddressPool"

#     metadata = {
#       name = "rancher-pool"
#       namespace = "metallb-system"
#     }

#     spec = {
#         addresses = [
#             "10.10.2.100/32"
#         ]

#     }
#   }

#   depends_on = [ helm_release.metallb, time_sleep.wait_10_seconds_crds ]
# }

# resource "kubernetes_manifest" "L2Advertisement" {
#   manifest = {
#     apiVersion = "metallb.io/v1beta1"
#     kind       = "L2Advertisement"

#     metadata = {
#       name = "rancher-l2"
#       namespace = "metallb-system"
#     }

#     spec = {
#         ipAddressPools = [
#             "rancher-pool"
#         ]

#     }
#   }

#   depends_on = [ helm_release.metallb, time_sleep.wait_10_seconds_crds ]

# }

