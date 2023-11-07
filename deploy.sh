#!/bin/bash

DOCKER_DEV_REPO="https://hub.docker.com/repository/docker/kani2b/capstone-dev/general"
DOCKER_PROD_REPO="https://hub.docker.com/repository/docker/kani2b/capstone-prod/general"

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [ "$CURRENT_BRANCH" == "dev" ]; then
    docker build -t react-app:dev .
    docker tag react-app:dev "$DOCKER_DEV_REPO/react-app:dev"
    docker push "$DOCKER_DEV_REPO/react-app:dev"
    echo "Deployed to dev repository"
elif [ "$CURRENT_BRANCH" == "master" ]; then
    docker build -t react-app:prod .
    docker tag react-app:prod "$DOCKER_PROD_REPO/react-app:prod"
    docker push "$DOCKER_PROD_REPO/react-app:prod"
    echo "Deployed to prod repository"
else
    echo "Not on dev or master branch, skipping deployment"
fi
