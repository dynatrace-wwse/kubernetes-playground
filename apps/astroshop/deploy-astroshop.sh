#!/bin/bash +x
 # Read the domain from CM
source ../util/loaddomain.sh

# Load the functions
source ../../cluster-setup/functions.sh

# set the Email for Certmanager to work
export CERTMANAGER_EMAIL=sergio@hinojosa.de

# enable the FF to install certmanager and call the functions
certmanager_install=true; certmanager_enable=true ; certmanagerInstall && certmanagerEnable

# Install Dynatrace
helm install dynatrace-operator oci://public.ecr.aws/dynatrace/dynatrace-operator --create-namespace --namespace dynatrace --atomic

# Set up Dynatrace variables
export DT_OTEL_API_TOKEN=dt0c01.XX.YY
export DT_OTEL_ENDPOINT=https://iid1110h.sprint.apps.dynatracelabs.com/api/v2/otlp

kubectl create namespace astroshop

helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts

###
# Instructions to install Astroshop with Helm Chart from R&D and images built in shinojos repo (including code modifications from R&D)
####

# TODO: replace domain for ingressHostUrl in both values file
# TODO: sed astroshop.35-177-159-64.nip.io
helm dependency build ./helm/dt-otel-demo-helm

kubectl create namespace astroshop

helm upgrade --install astroshop -f ./helm//dt-otel-demo-helm-deployments/values.yaml --set default.image.repository=docker.io/shinojosa/astroshop --set default.image.tag=1.12.0 --set collector_tenant_endpoint=$DT_OTEL_ENDPOINT --set collector_tenant_token=$DT_OTEL_API_TOKEN -n astroshop ./helm/dt-otel-demo-helm