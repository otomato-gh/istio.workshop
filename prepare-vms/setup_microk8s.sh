#! /bin/bash -f
#install docker (for building images)
sudo snap install docker
sudo snap install microk8s --classic --edge                                                                                                        
sudo snap install kubectl --classic
echo "source <(kubectl completion bash)" >> ~/.bashrc
sudo microk8s.start
# allow microk8s pods to communicate
sudo iptables -P FORWARD ACCEPT
# wait before enabling DNS
sleep 5
# retry enabling DNS (sometimes fails on first try
sudo microk8s.enable dns || sudo microk8s.enable dns
sleep 5
sudo microk8s.enable istio || sudo microk8s.enable istio
sudo chown -R $USER $HOME/.kube
sudo microk8s.kubectl config view --raw > $HOME/.kube/config
sudo chown $USER $HOME/.kube/config
#wait before enabling metrics server
sleep 5
sudo microk8s.enable metrics-server || sudo microk8s.enable metrics-server
sudo usermod -a -G microk8s $USER
# allow current user to access docker socket
sudo setfacl -m user:${USER}:rw /var/run/docker.sock
# allow microk8s pods to communicate
sudo iptables -P FORWARD ACCEPT
