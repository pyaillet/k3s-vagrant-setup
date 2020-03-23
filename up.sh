#!/usr/bin/env bash

if [ ! -f ./token ]; then
  head -c 64 </dev/urandom | xxd -o off -ps -c 64 > token
fi

if [ ! -f ./k3s ]; then
  curl -LO https://github.com/rancher/k3s/releases/latest/download/k3s
  chmod +x k3s
fi

if [ ! -f ./id_rsa ]; then
  ssh-keygen -t rsa -f ./id_rsa -q -N ""
fi

vagrant up

IP_SERVER=$(vagrant ssh server -c "ip address show enp0s8 | grep 'inet ' | sed -e 's/^.*inet //' -e 's/\/.*$//'" | tr -d "\n\r")
KUBECONFIG=k3s.yaml

rm -f "${KUBECONFIG}"

vagrant ssh server -c "sudo cat /etc/rancher/k3s/${KUBECONFIG}" \
  | sed -e "s/127.0.0.1/${IP_SERVER}/" > "${KUBECONFIG}"

kubectl --kubeconfig="${KUBECONFIG}" get nodes
