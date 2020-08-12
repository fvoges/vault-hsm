#!/bin/bash

apt-get install -y policycoreutils

restorecon -vr /opt/hashicorp/vault/bin/vault

useradd --system --home /etc/vault.d --shell /bin/false vault
usermod -a -G softhsm vault

ln -sfn /opt/hashicorp/vault/etc /etc/vault.d
ln -sfn /opt/hashicorp/vault/bin/* /usr/local/bin

mkdir -p /opt/raft /var/log/vault
chown vault:vault /opt/raft /var/log/vault

cat << EOF >> /root/.bashrc
#export VAULT_CACERT="/etc/vault.d/vault-ca.pem"
export VAULT_ADDR="https://127.0.0.1:8200"
EOF

cat << EOF > /etc/systemd/system/vault.service
[Unit]
Description="HashiCorp Vault - A tool for managing secrets"
Documentation=https://www.vaultproject.io/docs/
Requires=network-online.target
After=network-online.target
ConditionFileNotEmpty=/etc/vault.d/vault.hcl
StartLimitIntervalSec=60
StartLimitBurst=3

[Service]
User=vault
Group=vault
ProtectSystem=full
ProtectHome=read-only
PrivateTmp=yes
PrivateDevices=yes
SecureBits=keep-caps
AmbientCapabilities=CAP_IPC_LOCK
Capabilities=CAP_IPC_LOCK+ep
CapabilityBoundingSet=CAP_SYSLOG CAP_IPC_LOCK
NoNewPrivileges=yes
ExecStart=/usr/local/bin/vault server -config=/etc/vault.d/vault.hcl
ExecReload=/bin/kill --signal HUP $MAINPID
KillMode=process
KillSignal=SIGINT
Restart=on-failure
RestartSec=5
TimeoutStopSec=30
StartLimitInterval=60
StartLimitIntervalSec=60
StartLimitBurst=3
LimitNOFILE=65536
LimitMEMLOCK=infinity

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable vault
systemctl start vault
