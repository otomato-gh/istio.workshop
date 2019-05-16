# The Demo Installation

- microk8s installs the so-called _evaluation_ or _demo_ install of Istio

- It includes additional components:

  - Prometheus - for monitoring

  - Grafana - for dashboards

  - Jaeger - for tracing (see the istio-tracing-.. pod)

  - Servicegraph - to graph service connections

---
## The Demo Installation

- We can see pilot, galley, citadel... But where is the mixer?

.exercise[
```bash
kubectl get pod -n istio-system -l=istio=mixer
```
]

- Mixer has 2 functions: defining traffic policy and exposing traffic telemetry. 

- Therefore - 2 pods.


