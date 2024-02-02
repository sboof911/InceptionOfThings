#!/bin/sh


sudo mkdir -p /etc/rancher/k3s/
sudo touch /etc/rancher/k3s/kubelet.config

sudo echo -e "apiVersion: kubelet.config.k8s.io/v1beta1\nkind: KubeletConfiguration\nshutdownGracePeriod: 30s\nshutdownGracePeriodCriticalPods: 10s" > /etc/rancher/k3s/kubelet.config

token=`cat /vagrant/confs/cluster_token`

sudo echo "$token" > /etc/rancher/k3s/cluster-token


curl -sfL https://get.k3s.io | K3S_URL='https://192.168.56.110:6443' K3S_TOKEN="$token" sh -s - --node-label 'node_type=worker' --kubelet-arg 'config=/etc/rancher/k3s/kubelet.config' --kube-proxy-arg 'metrics-bind-address=0.0.0.0' --node-external-ip='192.168.56.111'
sudo cp /vagrant/confs/k3s.yaml /etc/rancher/k3s/
#kubectl label nodes <worker_node_name> kubernetes.io/role=worker
