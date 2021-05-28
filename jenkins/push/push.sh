#!/bin/bash

echo "********************"
echo "** Pushing image ***"
echo "********************"

echo "** Logging in ***"
docker login -u hiepph1707 -p $PASS

if [ $1 == "python" ]
then
    echo "*** Tagging image ***"
    docker tag ${IMAGE_PYTHON}:${IMAGE_TAG} hiepph1707/${IMAGE_PYTHON}:${IMAGE_TAG}
    docker push hiepph1707/${IMAGE_PYTHON}:${IMAGE_TAG}
elif [ $1 == "nodejs" ]
then
    echo "*** Tagging image ***"
    docker tag ${IMAGE_NODE}:${IMAGE_TAG} hiepph1707/${IMAGE_NODE}:${IMAGE_TAG}
    docker push hiepph1707/${IMAGE_NODE}:${IMAGE_TAG}
else
    echo "*** Tagging image ***"
    docker tag ${IMAGE_PYTHON}:${IMAGE_TAG} hiepph1707/${IMAGE_PYTHON}:${IMAGE_TAG}
    docker tag ${IMAGE_NODE}:${IMAGE_TAG} hiepph1707/${IMAGE_NODE}:${IMAGE_TAG}
    docker push hiepph1707/${IMAGE_PYTHON}:${IMAGE_TAG}
    docker push hiepph1707/${IMAGE_NODE}:${IMAGE_TAG}
fi
