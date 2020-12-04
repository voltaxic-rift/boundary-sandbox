#!/bin/bash

set -xeu

dnf install -y redis
systemctl start redis