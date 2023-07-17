#!/bin/bash
rm -f ~/.rancher/cli2.json
fullid=$(curl  -s --location --request GET "https://rancher.utahcounty.gov/v3/clusters/c-5xfdk/projects?name=$RANCHER_PROJECT_NAME" \
--header "Authorization: Bearer $1" | jq  -r '.data[0].id')
[[ $fullid ]] && echo "RANCHER_CONTEXT_ID=${fullid}" >> "$GITHUB_ENV"  || ( echo "Failed to retrieve contextID for project" && exit 2 )