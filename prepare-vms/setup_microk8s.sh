#! /bin/bash -f

sudo snap install microk8s --classic                                                                                                         
sudo snap install kubectl --classic                                                                                                          
microk8s.start                                                                                                                               
microk8s.enable istio                                                                                                          
microk8s.enable metrics-server         