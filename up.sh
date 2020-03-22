#!/usr/bin/env bash

curl -LO https://github.com/rancher/k3s/releases/latest/download/k3s
chmod +x k3s

ssh-keygen -t rsa -f ./id_rsa -q -N ""

vagrant up

vagrant ssh server -c "sudo cp /var/lib/rancher/k3s/server/tls/server-ca.crt /vagrant"
vagrant ssh server -c "sudo cp /var/lib/rancher/k3s/server/tls/client-admin.crt /vagrant"
vagrant ssh server -c "sudo cp /var/lib/rancher/k3s/server/tls/client-admin.key /vagrant"

kubectl --kubeconfig=k3s.kubeconfig get nodes
