#!/bin/bash

echo "****************************"
echo "** Building Docker Image ***"
echo "****************************"

if [ $1 == "python" ]
then
    # Copy source code to the build location
    cp -ar python jenkins/build/
    cd jenkins/build/ && /usr/local/bin/docker-compose -f docker-compose-python.yml build #--no-cache
elif [ $1 == "nodejs" ]
then
    # Copy source code to the build location
    cp -ar nodejs jenkins/build/
    cd jenkins/build/ && /usr/local/bin/docker-compose -f docker-compose-nodejs.yml build #--no-cache
else
    cp -ar {python,nodejs} jenkins/build/
    cd jenkins/build/ && /usr/local/bin/docker-compose -f docker-compose-all.yml build #--no-cache
fi





