ui           = true
cluster_addr = "https://vault-hcl:8201"
api_addr     = "https://vault-hcl:8200"
listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_disable   = false
  tls_cert_file = "/etc/vault.d/tls/vault-hsm.pem"
  tls_key_file  = "/etc/vault.d/tls/vault-hsm-key.pem"
}
storage "raft" {
  path          = "/opt/raft"
  node_id       = "vault-hcl" # e.g hostname
  # retry_join {                           # this needs to contain every other node in the raft cluster for auto-joining
  #   leader_api_addr = "https://<local-ip-node2>:8200"
  #   leader_ca_cert = "/path/to/ca1"
  #   leader_client_cert = "/path/to/client/cert1"
  #   leader_client_key = "/path/to/client/key1"
  # }
  # retry_join {
  #   leader_api_addr = "https://<local-ip-node3>:8200"
  #   leader_ca_cert = "/path/to/ca2"
  #   leader_client_cert = "/path/to/client/cert2"
  #   leader_client_key = "/path/to/client/key2"
  # }
}
seal "pkcs11" {
  lib            = "/usr/lib/softhsm/libsofthsm2.so"
  token_label    = "vault"
  pin            = "lolcats"
  key_label      = "vault-hsm-key"
  hmac_key_label = "vault-hsm-hmac-key"
  generate_key   = "true"
}
