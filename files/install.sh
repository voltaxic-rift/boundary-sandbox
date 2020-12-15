#!/bin/bash
# Installs the boundary as a service for systemd on linux
# Usage: ./install.sh <worker|controller>

TYPE=$1
NAME=boundary

cat << EOF > /etc/systemd/system/${NAME}-${TYPE}.service
[Unit]
Description=${NAME} ${TYPE}

[Service]
ExecStart=/usr/bin/${NAME} server -config /etc/${NAME}-${TYPE}.hcl
User=boundary
Group=boundary
LimitMEMLOCK=infinity
Capabilities=CAP_IPC_LOCK+ep
CapabilityBoundingSet=CAP_SYSLOG CAP_IPC_LOCK

[Install]
WantedBy=multi-user.target
EOF

# Add the boundary system user and group to ensure we have a no-login
# user capable of owning and running Boundary
adduser --system --group boundary || true
chown boundary:boundary /etc/${NAME}-${TYPE}.hcl

# Make sure to initialize the DB before starting the service. This will result in
# a database already initizalized warning if another controller or worker has done this
# already, making it a lazy, best effort initialization
if [ "${TYPE}" = "controller" ]; then
  /usr/bin/boundary database init -config /etc/${NAME}-${TYPE}.hcl > /vagrant/init.txt 2>&1 || true
fi

chmod 664 /etc/systemd/system/${NAME}-${TYPE}.service
systemctl daemon-reload
systemctl enable ${NAME}-${TYPE}
systemctl start ${NAME}-${TYPE}