#! /bin/bash -f
#install docker (for building images)
sudo snap install docker
sudo setfacl -m user:${USER}:rw /var/run/docker.sock
sudo snap install microk8s --classic                                                                                                         
sudo snap install kubectl --classic
echo "source <(kubectl completion bash)" >> ~/.bashrc                                                                                                          
microk8s.start                                                                                                                               
microk8s.enable istio                                                                                                          
microk8s.enable metrics-server