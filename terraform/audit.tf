resource "vault_audit" "syslog" {
  type = "syslog"

  options = {
    facility = "AUTH"
  }
}

resource "vault_audit" "file" {
  type = "file"

  options = {
    file_path = "/var/log/vault/audit.log"
  }
}
