#! /bin/bash -f
#install docker (for building images)
sudo snap install docker
sudo snap install microk8s --classic                                                                                                         
sudo snap install kubectl --classic
echo "source <(kubectl completion bash)" >> ~/.bashrc
sudo microk8s.start
sudo microk8s.enable istio
sudo microk8s.kubectl config view --raw > $HOME/.kube/config
sleep 5
sudo microk8s.enable metrics-server
# allow current user to access docker socket
sudo setfacl -m user:${USER}:rw /var/run/docker.sock
# allow istio pods to communicate
sudo iptables -P FORWARD ACCEPT
