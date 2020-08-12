# Vault Software HSM Vagrant environment

You need to download the zip files with HSM enabled Vault binaries, and put them in the bin directory.

```shell
vagrant up
vagrant ssh
/vagrant/scripts/certs-setup.sh
# ...
# profit
```

Check the scripts folder. The scripts automate most of the setup.

You need to run the certs-setup at least once. If you rebuild the VM, it will reuse the certs, but you will have to either use `VAULT_CAPATH` or run the following commands to avoid cert issues with the Vault CLI

```shell
mkdir /usr/share/ca-certificates/consul
cp /etc/vault.d/tls/consul-agent-ca.pem /usr/share/ca-certificates/consul/consul-agent-ca.crt
echo consul/consul-agent-ca.crt >> /etc/ca-certificates.conf
update-ca-certificates
```

The `hc-repos.sh` script also installs `consul` and `terraform` open source using the official package repo.

There's also a terraform folder. That one is for post configuration, and not really used for the HSM stuff.

## Note about rc files

Because I wrote this for myself, it installs my own set of rc files that I use everywhere. If you don't like that, just edit the `Vagrantfile` and remove this line from the shell provisioner (near the end of the file):

```shell
    curl https://gist.githubusercontent.com/fvoges/741de3b432e19c11c9bb/raw/3e71f78308a63f7a62cf9252131501b2e7338c7d/debian_install.sh|bash
```
