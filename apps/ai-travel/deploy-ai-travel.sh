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

kubectl create secret generic dynatrace --from-literal token=$DT_OTEL_API_TOKEN -n ai-travel
kubectl create secret generic otel-endpoint --from-literal endpoint=$OTLP_ENDPOINT -n ai-travel

###
# Patch the domain name with the real one
####
sed 's~domain.placeholder~'"$DOMAIN"'~' ./ingress.template > ./manifest/ingress.yaml

kubectl apply -f manifest/

printInfo "Deployment of AI Travel done."

printInfo "AI Travel available at: "

kubectl get ing -n ai-travel