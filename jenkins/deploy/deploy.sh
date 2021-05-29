#!/bin/bash

echo "****************************"
echo "** Deploy application ***"
echo "****************************"

/usr/bin/docker login -u hiepph1707 -p $PASS
if [ $1 == "python" ]
then
    cd jenkins/deploy/ && /usr/local/bin/docker-compose -f docker-compose-python.yml up -d
elif [ $1 == "nodejs" ]
then
    cd jenkins/deploy/ && /usr/local/bin/docker-compose -f docker-compose-nodejs.yml up -d
else
    cd jenkins/deploy/ && /usr/local/bin/docker-compose -f docker-compose-all.yml up -d 
fi