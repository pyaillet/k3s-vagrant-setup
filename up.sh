#!/usr/bin/env bash

curl -LO https://github.com/rancher/k3s/releases/latest/download/k3s
chmod +x k3s

ssh-keygen -t rsa -f ./id_rsa -q -N ""

vagrant up
