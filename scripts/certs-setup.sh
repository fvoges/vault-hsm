#!/bin/bash

ln -sfn /opt/hashicorp/consul/bin/* /usr/local/bin

mkdir -p /etc/vault.d/tls /usr/share/ca-certificates/consul
cd /etc/vault.d/tls

consul tls ca create
consul tls cert create -client \
  -additional-dnsname="vault-hsm" \
  -additional-dnsname="localhost" \
  -additional-ipaddress="127.0.0.1"

mv dc1-client-consul-0.pem vault-hsm.pem
mv dc1-client-consul-0-key.pem vault-hsm-key.pem

cp consul-agent-ca.pem /usr/share/ca-certificates/consul/consul-agent-ca.crt
echo consul/consul-agent-ca.crt >> /etc/ca-certificates.conf
update-ca-certificates

chmod -R o= /etc/vault.d/tls/*-key.pem
