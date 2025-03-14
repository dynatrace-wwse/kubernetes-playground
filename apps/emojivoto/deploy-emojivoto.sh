#!/bin/bash
# https://github.com/BuoyantIO/emojivoto

source ../util/loaddomain.sh

kubectl create ns emojivoto

# Create deployment of tictactoe
kubectl apply -k github.com/BuoyantIO/emojivoto/kustomize/deployment

## Create Ingress Rules
sed 's~domain.placeholder~'"$DOMAIN"'~' manifests/ingress.template > manifests/ingress.yaml

kubectl -n emojivoto apply -f manifests/ingress.yaml

echo "Emojivoto is available at.."
kubectl get ing -n emojivoto