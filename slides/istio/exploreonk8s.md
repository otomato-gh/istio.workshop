# Exploring Istio on K8s

- Istio on Kubernetes stores all data in ... Kubernetes

- Istio installs 20+ [CRDs](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions)

- Kubernetes API serves and handles the storage of these custom resources

- That means we communicate with Istio control plane via the K8s API

---
## Exploring Istio on K8s
.exercise[
- Let us see these CRDs
  ```bash
  kubectl get crd | grep istio
  ```
- Let us count how many we got
  ```bash
  kubectl get crd | grep istio | wc -l
  ```
]
--


23 resource definitions (Used to be 50+, but things are improving)

---
## Exploring Istio on K8s

 - Ok, that's where config is stored. But where are the processes?

```bash
kubectl get pod
```
 - Nothing here... Are they in kube-system?

```bash
kubectl get pod -n kube-system
```
 - Not here too!
---

## Exploring Istio on K8s

 - Let's look somewhere else

```bash
kubectl get ns
```
 - Hey, there's an *istio-system* namespace

```bash
kubectl get pod -n istio-system
```

- Now we're talking!

- But why so many?!

