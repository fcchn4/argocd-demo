#!/bin/bash

## Delete default files
rm -r Documents Music Pictures Public Templates tmp Videos

## Install Packages
echo "[x] SNAPD INSTALL"
apt-get update
apy-get upgrade
apt-get install -y snapd kubectl
snap install microk8s --classic --channel=1.31
usermod -a -G microk8s freddy
mkdir -p /home/freddy/.kube
chmod 0700 /home/freddy/.kube
chown -R freddy:freddy .kube/

## Install ArgoCD
wget https://github.com/argoproj/argo-cd/releases/download/v2.13.0-rc5/argocd-linux-amd64
mv argocd-linux-amd64 argocd
mv argocd /usr/local/bin/

## Post Install
echo "Execute command: sudo su - freddy"
echo "Execute command: microk8s kubectl config view --raw > ~/.kube/config"
