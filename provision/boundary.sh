#!/bin/bash

set -xeu

curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt update
apt install -y boundary

/vagrant/files/install.sh controller
/vagrant/files/install.sh worker