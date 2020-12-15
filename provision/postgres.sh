#!/bin/bash

set -xeu

adduser --system --group boundary || true

curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main"
apt-get update
apt-get install -y postgresql-13

echo "host all all all md5" >> /etc/postgresql/13/main/pg_hba.conf
sed -ri "s!^#?(listen_addresses)\s*=\s*\S+.*!\1 = '*'!" /etc/postgresql/13/main/postgresql.conf

systemctl restart postgresql
sudo -u postgres -i psql -c "create role boundary with login password 'boundary'"
sudo -u postgres -i psql -c "create database boundary"
sudo -u postgres -i psql -c "grant all privileges on database boundary to boundary"