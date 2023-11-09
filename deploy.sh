#!/bin/bash

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [ "$CURRENT_BRANCH" == "dev" ]; then
    ./build.sh
    docker tag react-app "kani2b/capstone-dev:dev"
    docker login
    docker push "kani2b/capstone-dev:dev"
    echo "Deployed to dev repository"
elif [ "$CURRENT_BRANCH" == "master" ]; then
    ./build.sh
    docker tag react-app "kani2b/capstone-prod:prod"
    docker login
    docker push "kani2b/capstone-prod:prod"
    echo "Deployed to prod repository"
else
    echo "Not on dev or master branch, skipping deployment"
fi
