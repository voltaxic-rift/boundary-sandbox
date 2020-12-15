#!/bin/bash

set -xeu

curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get update
apt-get install -y boundary

cp /vagrant/files/boundary-controller.hcl /etc/boundary-controller.hcl
cp /vagrant/files/boundary-worker.hcl /etc/boundary-worker.hcl

/vagrant/files/install.sh controller
/vagrant/files/install.sh worker