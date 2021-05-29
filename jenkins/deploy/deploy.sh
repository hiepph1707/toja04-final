#!/bin/bash

PYTHON_CT_NAME='python-app'
NODEJS_CT_NAME='nodejs-app'
echo "****************************"
echo "** Deploy application ***"
echo "****************************"

docker login -u hiepph1707 -p $PASS
if [ $1 == "python" ]
then
    if [ docker ps -aq --filter name=$PYTHON_CT_NAME ]
    then
        docker rm -f $PYTHON_CT_NAME
    fi
    docker run -d --name $PYTHON_CT_NAME -e "HOSTNAME=$(hostname -f)" -p 5000:5000 hiepph1707/my-python:latest
elif [ $1 == "nodejs" ]
then
    if [ docker ps -aq --filter name=$NODEJS_CT_NAME ]
    then
        docker rm -f $NODEJS_CT_NAME
    fi
    docker run -d --name $NODEJS_CT_NAME -e "HOSTNAME=$(hostname -f)" -p 5000:5000 hiepph1707/my-nodejs:latest
else
    cd jenkins/deploy/ && /usr/local/bin/docker-compose -f docker-compose-all.yml up -d 
fi