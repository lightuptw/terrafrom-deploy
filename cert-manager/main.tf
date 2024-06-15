variable "cloudflare-api-key" {
  type = string
  sensitive = true
}

variable "issuer-email" {
  type = string
  sensitive = true
}

module "cert_manager" {
  source        = "terraform-iaac/cert-manager/kubernetes"

  cluster_issuer_email                   = var.issuer-email
  cluster_issuer_name                    = "cert-manager-global"
  cluster_issuer_private_key_secret_name = "cert-manager-private-key"

  solvers = [
    {
        dns01 = {
            cloudflare = {
                apiTokenSecretRef = {
                        name = "cloudflare-api-key-secret"
                        key = "api-key"
                }
            }
        }
    }
  ]

  # additional_set = list(
  #   object({
  #     name  = "featureGates"
  #     value = "ExperimentalGatewayAPISupport=true"
  #   }),
  #   object({
  #     name  = "cainjector.nodeSelector"
  #     value = "production=true"
  #   }),
  #   object({
  #     name  = "webhook.nodeSelector"
  #     value = "production=true"
  #   }),
  #   object({
  #     name  = "startupapicheck.nodeSelector"
  #     value = "production=true"
  #   }),
  #   object({
  #     name  = "nodeSelector"
  #     value = "production=true"
  #   }),        
  # )
  additional_set = [
    {
        name  = "featureGates"
        value = "ExperimentalGatewayAPISupport=true"
    }
  ]
  
}


resource "kubectl_manifest" "cloudflare-api-key-secret" {
    yaml_body = yamlencode({
        apiVersion = "v1"
        kind = "Secret"
        metadata = {
            namespace = "cert-manager"
            name = "cloudflare-api-key-secret"
        }
        type = "Opaque"
        stringData = {
            api-key = var.cloudflare-api-key
        }
    })
#   yaml_body  = <<EOF
# apiVersion: v1
# kind: Secret
# metadata:
#   namespace: cert-manager
#   name: cloudflare-api-key-secret
# type: Opaque
# stringData:
#   api-key: "tfMyI_weJW_-HEfghh7fAg4Ck6tNbpcp3zwhrwSy"
# EOF
}