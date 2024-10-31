#!/bin/bash

## Delete default files
echo "[x] Delete User Default Files"
rm -r Documents Music Pictures Public Templates tmp Videos

## Install Packages
echo "[x] Snapd Install"
apt-get update
apy-get upgrade
apt-get install -y snapd kubectl
snap install microk8s --classic --channel=1.31
usermod -a -G microk8s $1
mkdir -p /home/$1/.kube
chmod 0700 /home/$1/.kube
chown -R $1:$1 .kube/

## Install ArgoCD
echo "[x] ArgoCD Install"
wget https://github.com/argoproj/argo-cd/releases/download/v2.13.0-rc5/argocd-linux-amd64
mv argocd-linux-amd64 argocd
mv argocd /usr/local/bin/

## Post Install
echo "Execute command: sudo su - $1"
echo "Execute command: microk8s kubectl config view --raw > ~/.kube/config"
