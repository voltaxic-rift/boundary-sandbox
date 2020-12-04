#!/bin/bash

set -xeu

dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

dnf install -y boundary docker-ce docker-ce-cli containerd.io libseccomp
usermod -aG docker vagrant
systemctl start docker