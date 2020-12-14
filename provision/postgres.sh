#!/bin/bash

set -xeu

adduser --system --group boundary || true

curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main"
apt update
apt install -y postgresql-13

cp -f /vagrant/files/postgres/pg_hba.conf /etc/postgresql/13/main/pg_hba.conf
cp -f /vagrant/files/postgres/postgresql.conf /etc/postgresql/13/main/postgresql.conf