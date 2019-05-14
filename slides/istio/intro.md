## Introduction

- This presentation was created by [Ant Weiss](https://twitter.com/antweiss) to support 
  instructor-led workshops.

- We included as much information as possible in these slides

- Most of the information this workshop is based on is public knowledge and can also be accessed through [Istio official documents and tutorials](https://istio.io/docs)

![image alt ><](images/istio.png)
---

## Training environment

- This is a hands-on training with exercises and examples

- We assume that you have access to a Kubernetes cluster

- The training labs for today's session were generously sponsored by [Strigo](https://strigo.io)
- We will be using [microk8s](https://microk8s.io) to get these clusters 

- Haven't tried microk8s yet?! You're in for a treat!

---

## Getting Istio

- Get the source code and the slides for this workshop:

.exercise[

- On your Strigo VM:

  ```bash
  git clone https://github.com/otomato-gh/istio.workshop.git 
  cd istio.workshop
  ./prepare_vms/setup_microk8s.sh
  ```

]

- This will install a microk8s single-node cluster with Istio

---

### A few words about microk8s

```bash
sudo snap install microk8s --classic                                    
sudo snap install kubectl --classic                                     
microk8s.start                                                          
microk8s.enable istio                                                   
```

- Single node Kubernetes done right

- Zero-ops k8s on just about any Linux box

- Many popular k8s add-ons can be enabled:
  - metrics-server
  - kube-dashboard
  - and of course: Istio
  - For more:  `microk8s.enable --help`


