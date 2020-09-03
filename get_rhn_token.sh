#!/bin/bash

#Set the offline token value (in this example, we set it in plaintext and shorten the token value for clarity)
offline_token=$(cat ./rhn_token)

#Create a function to easily filter out JSON values:
function jsonValue() {
KEY=$1                                            
num=$2
awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/'$KEY'\042/){print $(i+1)}}}' | tr -d '"' | sed -n ${num}p
}

export -f jsonValue

TOKEN=$(curl https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/token -d grant_type=refresh_token -d client_id=rhsm-api -d refresh_token=$offline_token | jsonValue access_token)

echo "Token: ${token}"

exit 0
