#!/bin/bash

echo "********************"
echo "** Pushing image ***"
echo "********************"

IMAGE="nodejs-project"

echo "** Logging in ***"
docker login -u hiepph1707 -p $PASS
echo "*** Tagging image ***"
docker tag $IMAGE:$DEPLOY_TAG hiepph1707/$IMAGE:$DEPLOY_TAG
echo "*** Pushing image ***"
docker push hiepph1707/$IMAGE:$DEPLOY_TAG
