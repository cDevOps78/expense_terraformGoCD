#provider "vault" {
#  address = "https://vault-internal.azcart.online:8200"
#
#  # token = ""   VAULT_TOKEN
#  skip_tls_verify = true  # VAULT_SKIP_VERIFY
#}

data "vault_kv_secret" "secret_data" {
  path = "common/ssh"
}