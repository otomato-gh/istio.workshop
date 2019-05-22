# Launching Darkly

- Our existing deployments already have a version label:

```yaml
      labels:
        app: beth
        version: v01
```

.exercise[
- Create a new deployment for `beth` in file `deployments/beth-v03.yaml` labeled as:

```yaml
version: v03
```

- Don't forget to also update delpoyment name and image name

- Deploy

```bash
kubectl apply -f  deployments/beth-v03.yaml
```
]
