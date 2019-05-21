# Deploying to K8s with Istio

The plan:

- Fix slowness by removing the `time.sleep(2)` line

- Build new version by building `localhost:32000/beth:0.2`

- Push the new version to our internal registry

- Update `beth` deployment to serve the new version
---

## Deploying by Kill-And-Replace

.exercise[
```bash
cd alephbeth/beth
docker build . -t localhost:32000/beth:0.2
docker push localhost:32000/beth:0.2
kubectl --record deployment.apps/beth set image deployment.v1.apps/beth beth=localhost:32000/beth:0.2
```
- Verify deployment is updated

- Check Jaeger to see if slowness is resolved

]

---