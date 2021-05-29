#!/bin/bash

PYTHON_CT_NAME='python-app'
NODEJS_CT_NAME='nodejs-app'

removeOldContainer () {
    echo "Remove old container"
    if [ $(docker ps -aq --filter name=$1) ]
    then
        docker rm -f $1
    fi
}

echo "****************************"
echo "** Deploy application ***"
echo "****************************"

# Login to Docker registry
docker login -u hiepph1707 -p $PASS

if [ $1 == "python" ]
then
    # Remove old python container
    removeOldContainer($PYTHON_CT_NAME)
    docker run -d --name $PYTHON_CT_NAME -e "HOSTNAME=$(hostname -f)" -p 5000:5000 hiepph1707/${IMAGE_PYTHON}:${IMAGE_TAG}
elif [ $1 == "nodejs" ]
then
    # Remove old nodejs container
    removeOldContainer($NODEJS_CT_NAME)
    docker run -d --name $NODEJS_CT_NAME -e "HOSTNAME=$(hostname -f)" -p 3000:3000 hiepph1707/${IMAGE_NODE}:${IMAGE_TAG}
else
    # Remove old nodejs container
    removeOldContainer($NODEJS_CT_NAME)
    removeOldContainer($PYTHON_CT_NAME)
    docker run -d --name $NODEJS_CT_NAME -e "HOSTNAME=$(hostname -f)" -p 3000:3000 hiepph1707/${IMAGE_NODE}:${IMAGE_TAG}
    docker run -d --name $PYTHON_CT_NAME -e "HOSTNAME=$(hostname -f)" -p 5000:5000 hiepph1707/${IMAGE_PYTHON}:${IMAGE_TAG} 
fi