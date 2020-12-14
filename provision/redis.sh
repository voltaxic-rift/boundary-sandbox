#!/bin/bash

set -xeu

add-apt-repository -y ppa:redislabs/redis
apt update
apt install -y redis