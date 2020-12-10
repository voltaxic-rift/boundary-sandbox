#!/bin/bash

set -xeu

dnf install -y postgresql-server
postgresql-setup --initdb

