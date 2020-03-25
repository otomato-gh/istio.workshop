## Now to the actual Istio installation
 
 ```bash
 curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.5.0 sh -
 cd istio-1.5.0
 #add the istioctl utility to the PATH
 export PATH=$PWD/bin:$PATH
```

Now - install Istio demo bundle 
```bash
istioctl manifest apply --set profile=demo
```
