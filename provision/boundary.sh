#!/bin/bash

set -xeu

dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
dnf install -y boundary

/vagrant/boundary_files/install.sh controller
/vagrant/boundary_files/install.sh worker

