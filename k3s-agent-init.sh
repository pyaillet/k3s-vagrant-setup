#!/usr/bin/env bash

mv /home/vagrant/k3s /usr/local/bin/
mv /home/vagrant/k3s-agent.service /etc/systemd/system/

mkdir -p /root/.ssh
cp /home/vagrant/.ssh/* /root/.ssh
cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

until ssh -o stricthostkeychecking=no root@${SERVER_IP} whoami; do sleep 3; done
scp -o stricthostkeychecking=no root@${SERVER_IP}:/var/lib/rancher/k3s/server/token /root/token

mkdir -p /etc/k3s
cat >> /etc/k3s/agent.conf <<EOF
NODE_IP=${NODE_IP}
NODE_EXTERNAL_IP=${NODE_IP}
NODE_NAME=${NODE_NAME}
SERVER_IP=${SERVER_IP}
TOKEN=$(cat /root/token)
EOF
systemctl enable k3s-agent
systemctl start k3s-agent
