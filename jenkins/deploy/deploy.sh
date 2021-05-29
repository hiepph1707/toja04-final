#!/bin/bash

PYTHON_CT_NAME='python-app'
NODEJS_CT_NAME='nodejs-app'
echo "****************************"
echo "** Deploy application ***"
echo "****************************"

docker login -u hiepph1707 -p $PASS
if [ $1 == "python" ]
then
    if [ $(docker ps -aq --filter name=$PYTHON_CT_NAME) ]
    then
        docker rm -f $PYTHON_CT_NAME
    fi
    docker run -d --name $PYTHON_CT_NAME -e "HOSTNAME=$(hostname -f)" -p 5000:5000 hiepph1707/${IMAGE_PYTHON}:${IMAGE_TAG}
elif [ $1 == "nodejs" ]
then
    if [ $(docker ps -aq --filter name=$NODEJS_CT_NAME) ]
    then
        docker rm -f $NODEJS_CT_NAME
    fi
    docker run -d --name $NODEJS_CT_NAME -e "HOSTNAME=$(hostname -f)" -p 3000:3000 ${IMAGE_NODE}:${IMAGE_TAG}
else
    
    if [ $(docker ps -aq --filter name=$PYTHON_CT_NAME) || $(docker ps -aq --filter name=$NODEJS_CT_NAME) ]
    then
        docker rm -f $NODEJS_CT_NAME && docker rm -f $PYTHON_CT_NAME
    fi
    docker run -d --name $NODEJS_CT_NAME -e "HOSTNAME=$(hostname -f)" -p 3000:3000 ${IMAGE_NODE}:${IMAGE_TAG}
    docker run -d --name $PYTHON_CT_NAME -e "HOSTNAME=$(hostname -f)" -p 5000:5000 ${IMAGE_PYTHON}:${IMAGE_TAG} 
fi