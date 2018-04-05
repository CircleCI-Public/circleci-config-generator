#!/bin/bash

git init

token="$(echo "$CIRCLE_TOKEN")"
circdir="./.circleci"
yaml="./.circleci/config.yml"
branch="$(git branch -a | grep circleci-20-test)"

if [ -z "$branch" ]
        then
                git checkout -b circleci-20-test
fi

if [ ! -d "$circdir" ]
        then
                mkdir "$circdir"
fi

echo "Enter URL to your project in the format https://circleci.com/platform/org/project"
read url

plat="$(echo "$url" | awk -F"/" '{ print $2 }')"
org="$(echo "$url" | awk -F"/" '{ print $3 }')"
proj="$(echo "$url" | awk -F"/" '{ print $4 }')"

curl -X GET "https://circleci.com/api/v1.1/project/"${plat}"/"${org}"/"${proj}"/config-translation?circle-token=$CIRCLE_TOKEN&branch=circleci-20-test" > "$yaml"
#git add "$circdir"
#git commit -m "Testing script-generated config.yml"
#git push origin circleci-20-test
