#!/bin/bash +x
 # Read the domain from CM
source ../util/loaddomain.sh

# Load the functions
source ../../cluster-setup/functions.sh

dynatraceEvalReadSaveCredentials
dynatrace_deploy_cloudnative=true
dynatraceDeployOperator

# enable the FF to install certmanager and call the functions
certmanager_install=true; certmanager_enable=true

certmanagerInstall && certmanagerEnable

kubectl create namespace astroshop

###
# Instructions to install Astroshop with Helm Chart from R&D and images built in shinojos repo (including code modifications from R&D)
####
sed -i 's~domain.placeholder~'"$DOMAIN"'~' helm/dt-otel-demo-helm/values.yaml
sed -i 's~domain.placeholder~'"$DOMAIN"'~' helm/dt-otel-demo-helm-deployments/values.yaml

helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts

helm dependency build ./helm/dt-otel-demo-helm

kubectl create namespace astroshop

helm upgrade --install astroshop -f ./helm/dt-otel-demo-helm-deployments/values.yaml --set default.image.repository=docker.io/shinojosa/astroshop --set default.image.tag=1.12.0 --set collector_tenant_endpoint=$DT_OTEL_ENDPOINT --set collector_tenant_token=$DT_OTEL_API_TOKEN -n astroshop ./helm/dt-otel-demo-helm
