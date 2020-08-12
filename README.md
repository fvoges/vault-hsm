# Vault Software HSM Vagrant environment

You need to download the zip files with HSM enabled Vault binaries, and put them in the bin directory.

```shell
vagrant up
vagrant ssh
# ...
# profit
```

Check the scripts folder. The scripts automate most of the setup. There's also a terraform folder. That one is for post configuration, and not really used for the HSM stuff.

There are consul and terraform binaries too. Consul is used to generate the TLS certs.
