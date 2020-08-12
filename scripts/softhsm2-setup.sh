#!/bin/bash

apt-get install -y libltdl7 libsofthsm2 softhsm2
mkdir -p /var/lib/softhsm/tokens/
softhsm2-util --init-token --free --label 'vault' --so-pin whiteclaw --pin rulez
# this is necessary so that the Vault process can read the files
chmod -R g+rXw /var/lib/softhsm/tokens
