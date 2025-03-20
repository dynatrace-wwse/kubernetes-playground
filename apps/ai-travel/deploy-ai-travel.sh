#!/bin/bash +x
 # Read the domain from CM
source ../util/loaddomain.sh

# Load the functions
# Read the variables
source ../../cluster-setup/functions.sh
source ../../cluster-setup/resources/dynatrace/credentials.sh

printInfoSection "Deploying AI Travel"

# read the credentials and variables
saveReadCredentials 

# To override the Dynatrace values call the function with the following order
#saveReadCredentials $DT_TENANT $DT_API_TOKEN $DT_INGEST_TOKEN $DT_OTEL_API_TOKEN $DT_OTEL_ENDPOINT

: <<'EOF'

# Dynatrace needs to be installed,
# achieved with this flag dynatrace_deploy_cloudnative=true
# DT_OTEL_API_TOKEN and DT_OTEL_ENDPOINT are exported

## Certmanager needs to be installed 
# enable the FF to install certmanager and call the functions
#certmanager_install=true; certmanager_enable=true
#certmanagerInstall && certmanagerEnable
EOF

kubectl create namespace ai-travel
OTLP_ENDPOINT="${DT_TENANT}"
if [[ $OTLP_ENDPOINT == */ ]]
then
    echo "asd"
    OTLP_ENDPOINT="${OTLP_ENDPOINT}api/v2/otlp/v1/traces"
else
    echo "das"
    OTLP_ENDPOINT="${OTLP_ENDPOINT}/api/v2/otlp/v1/traces"
fi

echo "Configuration URL $OTLP_ENDPOINT and OTel Token $DT_OTEL_API_TOKEN"  

exit 1

kubectl create secret generic dynatrace --from-literal token=$DT_OTEL_API_TOKEN -n ai-travel
kubectl create secret generic otel-endpoint --from-literal endpoint=$DT_TENANT -n ai-travel

###
# Patch the domain name with the real one
####
sed 's~domain.placeholder~'"$DOMAIN"'~' ./ai-travel/ingress.template > ./ai-travel/ingress.yaml

kubectl apply -f ./ai-travel

printInfo "Deployment of AI Travel done."


printInfo "AI Travel available at: "

kubectl get ing -n ai-travel