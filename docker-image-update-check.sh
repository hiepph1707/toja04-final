#!/bin/bash

IMAGE_PYTHON="hiepph1707/my-python"
IMAGE_NODEJS="hiepph1707/my-nodejs"
PYTHON_CT_NAME='python-app'
NODEJS_CT_NAME='nodejs-app'

removeOldContainer () {
    echo "Remove old container"
    if [ $(docker ps -aq --filter name=$1) ]
    then
        docker rm -f $1
    fi
}

echo "Fetching Docker Hub token..."
token_python=$(curl --silent "https://auth.docker.io/token?scope=repository:$IMAGE_PYTHON:pull&service=registry.docker.io" | jq -r '.token')
token_nodejs=$(curl --silent "https://auth.docker.io/token?scope=repository:$IMAGE_NODEJS:pull&service=registry.docker.io" | jq -r '.token')

echo "Fetching remote digest... "
digest_python=$(curl --silent -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
        -H "Authorization: Bearer $token_python" \
        "https://registry.hub.docker.com/v2/$IMAGE_PYTHON/manifests/latest" | jq -r '.config.digest')
echo "Remote digest Python: $digest_python"
local_digest_python=$(docker images -q --no-trunc $IMAGE_PYTHON:latest)
echo "Local digest Python: $local_digest_python"

digest_nodejs=$(curl --silent -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
        -H "Authorization: Bearer $token_nodejs" \
        "https://registry.hub.docker.com/v2/$IMAGE_NODEJS/manifests/latest" | jq -r '.config.digest')
echo "REmote digest NodeJS: $digest_nodejs"
local_digest_nodejs=$(docker images -q --no-trunc $IMAGE_NODEJS:latest)
echo "Local digest NodeJs $local_digest_nodejs"

if [ "$digest_python" != "$local_digest_python" ] ; then
        echo "Pulling latest version $IMAGE_PYTHON..."
        docker pull $IMAGE_PYTHON
        removeOldContainer $PYTHON_CT_NAME
        docker run -d --name $PYTHON_CT_NAME -e "HOSTNAME=$(hostname -f)" -p 5000:5000 ${IMAGE_PYTHON}
elif [ "$digest_nodejs" != "$local_digest_nodejs"  ]; then
        echo "Pulling latest version $IMAGE_NODEJS..."
        docker pull $IMAGE_NODEJS
        removeOldContainer $NODEJS_CT_NAME
        docker run -d --name $NODEJS_CT_NAME -e "HOSTNAME=$(hostname -f)" -p 3000:3000 ${IMAGE_NODEJS}
else
        echo "Already up to date. Nothing to do."
fi