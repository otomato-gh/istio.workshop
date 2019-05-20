# Deploying with Istio

- Our purpose today is to learn how Istio allows us to implement *progressive delivery* techniques

- We'll do that by deploying a demo application - an *alphabeth* system :)

- It's just a frontend service that speaks to 2 backends (aleph and beth)

- All the services are bare-bones Python Flask apps

---

class: pic
## The Sample App 
![diagram](images/demoapp.png)

---

## What's on the menu?

In this part, we will:

- **build** images for our app,

- **ship** these images with a registry,

- **run** deployments using these images,

- expose these deployments so they can communicate with each other,

- expose the web UI so we can access it from outside.

---

## The plan

- Build in the cluster using  `kaniko`)

- Tag images so that they are named `$REGISTRY/servicename`

- Upload them to a registry

- Create deployments using the images

- Expose (with a ClusterIP) the services that need to communicate

- Expose (with a NodePort) the WebUI

---

## Which registry do we want to use?

- We could use the Docker Hub

- Or a service offered by our cloud provider (GCR, ECR...)

- Or we could just self-host that registry

*We'll self-host the registry because it's the most generic solution for this workshop.*

---

## Using the open source registry

- We need to run a `registry:2` container
  <br/>(make sure you specify tag `:2` to run the new version!)

- It will store images and layers to the local filesystem
  <br/>(but you can add a config file to use S3, Swift, etc.)

- Docker *requires* TLS when communicating with the registry

  - unless for registries on `127.0.0.0/8` (i.e. `localhost`)

  - or with the Engine flag `--insecure-registry`

- Our strategy: publish the registry container on a NodePort,
  <br/>so that it's available through `127.0.0.1:xxxxx` on each node

---

# Deploying a self-hosted registry

- We will deploy a registry container, and expose it with a NodePort

.exercise[

- Create the registry service:
  ```bash
  kubectl run registry --image=registry:2
  ```

- Expose it on a NodePort:
  ```bash
  kubectl expose deploy/registry --port=5000 --type=NodePort
  ```

]

---

## Connecting to our registry

- We need to find out which port has been allocated

.exercise[

- View the service details:
  ```bash
  kubectl describe svc/registry
  ```

- Get the port number programmatically:
  ```bash
  NODEPORT=$(kubectl get svc/registry -o json | jq .spec.ports[0].nodePort)
  REGISTRY=127.0.0.1:$NODEPORT
  ```

]

---

## Testing our registry

- A convenient Docker registry API route to remember is `/v2/_catalog`

.exercise[

- View the repositories currently held in our registry:
  ```bash
  curl $REGISTRY/v2/_catalog
  ```

]

--

We should see:
```json
{"repositories":[]}
```

---

## Testing our local registry

- We can retag a small image, and push it to the registry

.exercise[

- Make sure we have the busybox image, and retag it:
  ```bash
  docker pull busybox
  docker tag busybox $REGISTRY/busybox
  ```

- Push it:
  ```bash
  docker push $REGISTRY/busybox
  ```

]

---

## Checking again what's on our local registry

- Let's use the same endpoint as before

.exercise[

- Ensure that our busybox image is now in the local registry:
  ```bash
  curl $REGISTRY/v2/_catalog
  ```

]

The curl command should now output:
```json
{"repositories":["busybox"]}
```

---

## Building and pushing our images

- We are going to use a convenient feature of Docker Compose

.exercise[

- Go to the `alephbeth` directory:
  ```bash
  cd ~/istio.workshop/alephbeth
  ```

- Build and push the images:
  ```bash
  export REGISTRY
  docker-compose build
  docker-compose push
  ```

]

Let's have a look at the `docker-compose.yaml` file while this is building and pushing.

---

```yaml
services:
  front:
    build: front
    image: ${REGISTRY}/istio-games-front:${TAG-0.3}  
  aleph:
    build: aleph
    image: ${REGISTRY}/istio-games-aleph:${TAG-0.3}
  beth:
    build: beth
    image: ${REGISTRY}/istio-games-beth:${TAG-0.3}
  mongo:
    image: mongo
```

---

## Deploying all the things

- We can now deploy our code (as well as a redis instance)

.exercise[

- Deploy `redis`:
  ```bash
  kubectl run redis --image=redis
  ```

- Deploy everything else:
  ```bash
    for SERVICE in hasher rng webui worker; do
      kubectl run $SERVICE --image=$REGISTRY/$SERVICE
    done
  ```

]

---

## Is this working?

- After waiting for the deployment to complete, let's look at the logs!

  (Hint: use `kubectl get deploy -w` to watch deployment events)

.exercise[

- Look at some logs:
  ```bash
  kubectl logs deploy/rng
  kubectl logs deploy/worker
  ```

]

--

🤔 `rng` is fine ... But not `worker`.

--

💡 Oh right! We forgot to `expose`.

---

# Exposing services internally 

- Three deployments need to be reachable by others: `hasher`, `redis`, `rng`

- `worker` doesn't need to be exposed

- `webui` will be dealt with later

.exercise[

- Expose each deployment, specifying the right port:
  ```bash
  kubectl expose deployment redis --port 6379
  kubectl expose deployment rng --port 80
  kubectl expose deployment hasher --port 80
  ```

]

---

## Is this working yet?

- The `worker` has an infinite loop, that retries 10 seconds after an error

.exercise[

- Stream the worker's logs:
  ```bash
  kubectl logs deploy/worker --follow
  ```

  (Give it about 10 seconds to recover)

<!--
```keys
^C
```
-->

]

--

We should now see the `worker`, well, working happily.

---

# Exposing services for external access

- Now we would like to access the Web UI

- We will expose it with a `NodePort`

  (just like we did for the registry)

.exercise[

- Create a `NodePort` service for the Web UI:
  ```bash
  kubectl expose deploy/webui --type=NodePort --port=80
  ```

- Check the port that was allocated:
  ```bash
  kubectl get svc
  ```

]

---

## Accessing the web UI

- We can now connect to *any node*, on the allocated node port, to view the web UI

.exercise[

- Open the web UI in your browser (http://node-ip-address:3xxxx/)

<!-- ```open http://node1:3xxxx/``` -->

]

--

*Alright, we're back to where we started, when we were running on a single node!*
