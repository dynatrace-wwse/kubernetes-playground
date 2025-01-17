#!/bin/bash +x
# Set up of the Book application of istio for Microk8s
# https://istio.io/docs/examples/bookinfo/
 
# Read the domain from CM
source ../util/loaddomain.sh

###
# Instructions to install Astroshop with Helm Chart from R&D and images built in shinojos repo (including code modifications from R&D)
####


# --   Install  Dynatrace -----
#helm install dynatrace-operator oci://public.ecr.aws/dynatrace/dynatrace-operator --create-namespace --namespace dynatrace --atomic
#kubectl apply -f dynakube.yaml

# Deploy fluentbit for gathering all logs
#helm repo add fluent https://fluent.github.io/helm-charts
#helm repo update
#helm install fluent-bit fluent/fluent-bit -f fluent-bit-values.yaml --create-namespace --namespace dynatrace-fluent-bit

# Install certmanager for OTEL to work correctly, using v1.15.3
# sudo su
# source functions.sh
# export the email in the env
export CERTMANAGER_EMAIL=sergio@hinojosa.de
# enable the FF to install certmanager and call the functions
certmanager_install=true; certmanager_enable=true ; certmanagerInstall && certmanagerEnable

# TODO: replace domain for ingressHostUrl in both values file
# TODO: sed astroshop.35-177-159-64.nip.io
helm dependency build ./helm/dt-otel-demo-helm
kubectl create namespace astroshop
#kubectl label namespace astroshop dynatrace.com/inject=true

# TODO
export DT_OTEL_API_TOKEN=dt0c01.xx.yy
export DT_OTEL_ENDPOINT=https://iid1110h.sprint.apps.dynatracelabs.com/api/v2/otlp

helm upgrade --install astroshop -f ./helm//dt-otel-demo-helm-deployments/values.yaml --set default.image.repository=docker.io/shinojosa/astroshop --set default.image.tag=1.12.0 --set collector_tenant_endpoint=$DT_OTEL_ENDPOINT --set collector_tenant_token=$DT_OTEL_API_TOKEN -n astroshop ./helm/dt-otel-demo-helm
