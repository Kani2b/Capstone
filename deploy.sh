#!/bin/bash

if [ "$CURRENT_BRANCH" == "origin/dev" ]; then
    ./build.sh
    docker tag react-app "kani2b/capstone-dev:dev"
    docker login -u kani2b -p dckr_pat_XQJzIzQcsy0RDmjGA1nOywp08IA
    docker push "kani2b/capstone-dev:dev"
    echo "Deployed to dev repository"
elif [ "$CURRENT_BRANCH" == "origin/master" ]; then
    ./build.sh
    docker tag react-app "kani2b/capstone-prod:prod"
    docker login -u kani2b -p dckr_pat_XQJzIzQcsy0RDmjGA1nOywp08IA
    docker push "kani2b/capstone-prod:prod"
    echo "Deployed to prod repository"
else
    echo "Not on dev or master branch, skipping deployment"
fi
