#!/bin/sh


sudo mkdir -p /etc/rancher/k3s/
sudo touch /etc/rancher/k3s/kubelet.config

sudo echo -e "apiVersion: kubelet.config.k8s.io/v1beta1\nkind: KubeletConfiguration\nshutdownGracePeriod: 30s\nshutdownGracePeriodCriticalPods: 10s" > /etc/rancher/k3s/kubelet.config


curl -sfL https://get.k3s.io | sh -s - server --write-kubeconfig-mode '0644' --node-taint 'node-role.kubernetes.io/master=true:NoSchedule' --disable 'servicelb' --disable 'traefik' --disable 'local-path' --kube-controller-manager-arg 'bind-address=0.0.0.0' --kube-proxy-arg 'metrics-bind-address=0.0.0.0' --kube-scheduler-arg 'bind-address=0.0.0.0' --kubelet-arg 'config=/etc/rancher/k3s/kubelet.config' --kube-controller-manager-arg 'terminated-pod-gc-threshold=10' --node-external-ip='192.168.56.110'
sudo cat /var/lib/rancher/k3s/server/node-token > /vagrant/confs/cluster-token
sudo cp /etc/rancher/k3s/k3s.yaml /vagrant/confs/
