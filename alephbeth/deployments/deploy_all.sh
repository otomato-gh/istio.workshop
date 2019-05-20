#! /bin/bash -f
kubectl create ns staging
kubectl label ns staging istio-injection=enabled
kubectl apply -f aleph.yaml  -f front.yaml -f beth.yaml  -n staging 
