# Progressive Delivery Strategies

**Progressive Delivery* is the collective definition 
for a set of deployment techniques that allow for gradual,
reliable and low-stress release of new software versions into production environments.
Istio's advanced traffic shaping capabilities make some of these techinques significantly easier.

Techniques we will be looking at today are:

- Dark launch

- Canary deployments

- Traffic mirroring


---

## Dark Launch

**Dark Launch** refers to the process where the new version is released to production but is only available to internal or *friendly* users - via feature toggles or smart routing. This way we can battle-test new features and bug fixes in production long before the paying customers get affected.

![img alt=><](images/darklaunch.png)

---

## Canary Deployments

**Canary Deployments* is the process in which a new version that is released to production gets only a tiny percent of actual production traffic. While the rest of traffic continues to be served by the old version. This may cause a minimal, sufferable service disruption. If the new version functions fine - we gradually switch more traffic over to it from the old version. Until all traffic is served by the new version and the old version can be retired.

![img alt=><](images/canary.png)

---

## Traffic Mirroring

*Traffic Mirroring* (or traffic shadowing) is more of a testing technique whereas we release the new version to production and channel *all* the production traffic to it. This happens in parallel to serving this traffic by the old version. No responses are sent back from the new version. 
This allows us to test the new version with full production traffic and data without impacting our users.

![img alt=><](images/mirroring.png)

---
## How Can Istio Help

- Let's see how we can implement all of the above with Istio's help

- But first let's learn the basics of Istio traffic management
