#!/bin/bash

PYTHON_CT_NAME='python-app'
NODEJS_CT_NAME='nodejs-app'
echo "****************************"
echo "** Deploy application ***"
echo "****************************"

# Remove old python container
if [ $(docker ps -aq --filter name=$PYTHON_CT_NAME) ]
then
    docker rm -f $PYTHON_CT_NAME
fi

# Remove old nodejs container
if [ $(docker ps -aq --filter name=$NODEJS_CT_NAME) ]
then
    docker rm -f $NODEJS_CT_NAME
fi

# Login to Docker registry
docker login -u hiepph1707 -p $PASS

if [ $1 == "python" ]
then
    docker login -u hiepph1707 -p $PASS
    docker run -d --name $PYTHON_CT_NAME -e "HOSTNAME=$(hostname -f)" -p 5000:5000 hiepph1707/${IMAGE_PYTHON}:${IMAGE_TAG}
elif [ $1 == "nodejs" ]
then
    docker login -u hiepph1707 -p $PASS
    docker run -d --name $NODEJS_CT_NAME -e "HOSTNAME=$(hostname -f)" -p 3000:3000 ${IMAGE_NODE}:${IMAGE_TAG}
else
    docker login -u hiepph1707 -p $PASS
    docker run -d --name $NODEJS_CT_NAME -e "HOSTNAME=$(hostname -f)" -p 3000:3000 ${IMAGE_NODE}:${IMAGE_TAG}
    docker run -d --name $PYTHON_CT_NAME -e "HOSTNAME=$(hostname -f)" -p 5000:5000 ${IMAGE_PYTHON}:${IMAGE_TAG} 
fi