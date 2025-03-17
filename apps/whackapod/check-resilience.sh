#!/bin/bash
echo "Usage: sh check-resilience.sh "
echo "Press [CTRL+C] to stop.."
export PUBLIC_IP=$(curl -s ifconfig.me) 
PUBLIC_IP_AS_DOM=$(echo $PUBLIC_IP | sed 's~\.~-~g')
export DOMAIN="${PUBLIC_IP_AS_DOM}.nip.io"

url="http://whackapod.$DOMAIN/api/"

contentType="Content-Type: application/json"
dtHeaderGet="x-dynatrace-test: LSN=check-whackapod-service.sh;LTN=CheckService;TSN=Check health of service;"

endless_check(){
  echo -e "\nChecking the health of the WackAPoD Service\n"
  while true
  do
    # Endless loop
    check_svc
    sleep 1
  done
}
# Do a URL Check with a timeut of 500
check_svc(){
  response=$(curl -s -X GET -H "$contentType" -H "$dtHeaderGet" $url --connect-timeout 0.5)
  printf "Check: $url :$response \n"
  
}
endless_check