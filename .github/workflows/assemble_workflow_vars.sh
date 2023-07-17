#!/bin/bash
# Assemble the dynamic variables
github_repo_name=$(echo "${GITHUB_REPOSITORY#*/}" | tr '[:upper:]' '[:lower:]')                 # ITDeptUtahCountyGovernment/IT-web-template
repo_dept_prefix=${github_repo_name%%-*}                                                        # IT
repo_no_prefix=${github_repo_name#*-}                                                           # web-template
stamp=$(TZ=US/Mountain date +"%m.%d-%p%I.%M")                                                   # 08.18-PM06.49
image_tag=${stamp}-$(echo ${GITHUB_SHA} | cut -c1-7 )-$(echo $GITHUB_REF_NAME | sed 's,/,-,g')  # 08.18-PM06.49-ffac537-staging
docker_image_name=dockreg.utahcounty.gov/$repo_dept_prefix/$repo_no_prefix                      # dockreg.utahcounty.gov/IT/web-template
docker_image=$(echo "$docker_image_name:$image_tag" | tr '[:upper:]' '[:lower:]') # dockreg.utahcounty.gov/IT/web-template-server:08.18-PM06.49-ffac537-staging
rancher_namespace=it-wiki-$(echo $GITHUB_REF_NAME | sed 's,/,-,g')                    # IT-web-template-staging

# Always export the shortened SHA
echo "GITHUB_SHA_SHORT=$(echo ${GITHUB_SHA} | cut -c1-7 )" >> $GITHUB_ENV
# TO-DO: validate names against related resource naming contrainsts (K8 namespace, projectname, Docker Image, Label, Tag)
# Export vars to GITHUB_ENV allow override from ENV presets
[[ $RANCHER_NAMESPACE ]]    && echo "RANCHER_NAMESPACE=$RANCHER_NAMESPACE"     >> $GITHUB_ENV || echo "RANCHER_NAMESPACE=$rancher_namespace"     >> $GITHUB_ENV 
[[ $DOCKER_IMAGE ]]  && echo "DOCKER_IMAGE=$DOCKER_IMAGE" >> $GITHUB_ENV || echo "DOCKER_IMAGE=$docker_image" >> $GITHUB_ENV 
[[ $RANCHER_NAMESPACE ]]    && echo "RANCHER_NAMESPACE=$RANCHER_NAMESPACE"     >> $GITHUB_ENV || echo "RANCHER_NAMESPACE=$rancher_namespace"     >> $GITHUB_ENV
