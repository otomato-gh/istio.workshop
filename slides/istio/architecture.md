class: pic
# Istio Architecture

![architecture](https://istio.io/docs/concepts/what-is-istio/arch.svg)

---
## Envoy

Envoy is a high-performance proxy developed in C++ to mediate all inbound and outbound traffic for all services in the service mesh. 

Istio leverages Envoy’s many built-in features, for example:

 - Dynamic service discovery
 - Load balancing
 - TLS termination
 - HTTP/2 and gRPC proxies
 - Circuit breakers
 - Health checks
 - Staged rollouts with %-based traffic split
 - Fault injection
 - Rich metrics

---

## Mixer
 
 Mixer is a platform-independent component. 

 - Enforces access control and usage policies

 - Collects telemetry data from the Envoy proxy and other Istio components.

 - The proxy extracts request level attributes, and sends them to Mixer for evaluation. 

 Mixer includes a flexible plugin model. 
---

## Pilot
 
  - Service discovery for the Envoy proxies

  - Traffic management capabilities for intelligent routing (e.g., A/B tests, canary rollouts, etc.)

  - Resiliency (timeouts, retries, circuit breakers, etc.).
---
  
## Citadel

- creates a SPIFFE certificate and key pair for each of the existing and new service accounts

- stores the certificate and key pairs as Kubernetes secrets.

- when you create a pod, Kubernetes mounts the certificate and key pair to the pod according to its service account 

- Citadel watches the lifetime of each certificate, and automatically rotates the certificates by rewriting the Kubernetes secrets.

---
## Galley

- validates configuration

- will abstract Istio from underlying platform (i.e Kubernetesß)