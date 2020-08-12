#!/bin/bash

apt-get install -y libltdl7 libsofthsm2 softhsm2
mkdir -p /var/lib/softhsm/tokens/
chmod -R g+rXw /var/lib/softhsm/tokens
softhsm2-util --init-token --free --label 'vault' --so-pin whiteclaw --pin rulez
