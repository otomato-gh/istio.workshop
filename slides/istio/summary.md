# Summing It All Up

- We've learned what a Service Mesh is

- We've learned how Istio works

- We've seen the following progressive delivery strategies:

  - Dark Launch

  - Traffic Mirroring

  - Canary Deployment

---

## Wrap-up Exercise

- Check out `wrapup` branch of istio.workshop

.exercise[

```bash
git checkout wrapup
```
]

- Build and push new version of `aleph`
.exercise[

```bash
cd aleph
docker build . -t ${REGISTRY}/aleph:0.2
docker push ${REGISTRY}/aleph:0.2
```
]

---

## Wrap-up Exercise

- Create a DestinationRule for aleph in namespace `staging`:

    - With subset `production` pointing at pods with label `version=v01`
    - With subset `canary` pointing at pods with label `version=v02`

- Create a VirtualService in namespace `staging`:

    - Default route: `aleph` with subset `production`

    - Mirror traffic to subset `canary`

- Create a new deployment `aleph-v02` with labels :

    - version: v02
    - app: aleph

---

## Wrap Up Exercise

- Generate load on aleph service

- (Hint: use the `curler` pod we've created)

- Check Graphana for aleph service stats

- Is the new version healthy?

