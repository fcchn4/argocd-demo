#!/bin/bash

## Delete default files
echo "[x] Delete User Default Files"
rm -r /home/$1/Documents /home/$1/Music /home/$1/Pictures /home/$1/Public /home/$1/Templates /home/$1/tmp /home/$1/Videos

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
chmod +x /usr/local/bin/argocd
chown $1:$1 /usr/local/bin/argocd

## Post Install
echo "Execute command: sudo su - $1"
echo "Execute command: microk8s kubectl config view --raw > ~/.kube/config"
