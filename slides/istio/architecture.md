class: pic
# Istio Architecture

![architecture](https://istio.io/docs/ops/deployment/architecture/arch.svg)

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

## The Sidecar Pattern
- The 'sidecar' is a an assistant container in the pod

- Think Batman's Robin

- It takes on some responsibility that the main container can't be bothered with
  
  - Log shipping

  - Data preparation

  - Or in our case : networking!
---

## Pilot
 
  - Service discovery for the Envoy proxies

  - Traffic management capabilities for intelligent routing (e.g., A/B tests, canary rollouts, etc.)

  - Resiliency (timeouts, retries, circuit breakers, etc.).

  ![pilot](https://istio.io/docs/ops/deployment/architecture/discovery.svg)
---
  
## Citadel

- creates a [SPIFFE](https://spiffe.io/) certificate and key pair for each of the existing and new service accounts

- stores the certificate and key pairs as Kubernetes secrets.

- when you create a pod, Kubernetes mounts the certificate and key pair to the pod according to its service account 

- Citadel watches the lifetime of each certificate, and automatically rotates the certificates by rewriting the Kubernetes secrets.

---
## Galley

- validates configuration

- Abstracts Istio from underlying platform (i.e Kubernetes)
---

## Once there was a Mixer
 
 Mixer used to be the main performance bottleneck of Istio 

 - Managed policy definition and enforcement.
   - Now this happens in **istiod**

 - Collected telemetry data. 
   - Now this is done **in proxy**.

 - Provided a flexible plugin model. 
   - Now replaced by [Envoy WASM extensions](https://istio.io/blog/2020/wasm-announce/)