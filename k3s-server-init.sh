#!/usr/bin/env bash

mv /home/vagrant/k3s /usr/local/bin/
mv /home/vagrant/k3s-server.service /etc/systemd/system/

mkdir -p /etc/k3s
mv /home/vagrant/token /etc/k3s/

cat >> /etc/k3s/server.conf <<EOF
NODE_IP=$NODE_IP
NODE_EXTERNAL_IP=$NODE_IP
NODE_NAME=$NODE_NAME
EOF
systemctl enable k3s-server
systemctl start k3s-server
