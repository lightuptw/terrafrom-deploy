ansible-playbook -i hosts deploy_rke2.yaml

acme.sh --register-account \
   --server letsencrypt_test \
   -m saqwxz06@gmail.com



global
    stats socket /var/run/haproxy/admin.sock level admin mode 660
    setenv ACCOUNT_THUMBPRINT 'IBzq91Hj7FdkwcKEZzR90M6BTNbdkIY_yT5GXlkxp34'

    acme.sh --issue \
   -d lb.net-chain.xyz \
   --dns \
   --server letsencrypt_test


acme.sh --issue -d lb.net-chain.xyz --dns \
 --yes-I-know-dns-manual-mode-enough-go-ahead-please

acme.sh --renew -d lb.net-chain.xyz --dns \
  --yes-I-know-dns-manual-mode-enough-go-ahead-please

wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
 apt update && apt install vault

[Wed Jan 17 16:24:16 UTC 2024] Your cert is in: /root/.acme.sh/lb.net-chain.xyz_ecc/lb.net-chain.xyz.cer
[Wed Jan 17 16:24:16 UTC 2024] Your cert key is in: /root/.acme.sh/lb.net-chain.xyz_ecc/lb.net-chain.xyz.key
[Wed Jan 17 16:24:16 UTC 2024] The intermediate CA cert is in: /root/.acme.sh/lb.net-chain.xyz_ecc/ca.cer
[Wed Jan 17 16:24:16 UTC 2024] And the full chain certs is there: /root/.acme.sh/lb.net-chain.xyz_ecc/fullchain.cer

bind *:443 ssl crt /root/.acme.sh/lb.net-chain.xyz_ecc/lb.net-chain.xyz.key

cat /root/.acme.sh/lb.net-chain.xyz_ecc/lb.net-chain.xyz.cer /root/.acme.sh/lb.net-chain.xyz_ecc/lb.net-chain.xyz.key > /root/.acme.sh/lb.net-chain.xyz_ecc/lb.net-chain.xyz.pem