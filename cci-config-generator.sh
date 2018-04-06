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

plat="$(echo "$url" | awk -F"/" '{ print $4 }')"
echo $plat
org="$(echo "$url" | awk -F"/" '{ print $5 }')"
echo $org
proj="$(echo "$url" | awk -F"/" '{ print $6 }')"
echo $proj

if [ "$plat" == "gh" ]
	then
		pl="github"
elif [ "$plat" == "bb" ]
	then
		pl="bitbucket"
fi


curl -X GET "https://circleci.com/api/v1.1/project/"${pl}"/"${org}"/"${proj}"/config-translation?circle-token=$CIRCLE_TOKEN&branch=circleci-20-test" > ./config
#git add "$circdir"
#git commit -m "Testing script-generated config.yml"
#git push origin circleci-20-test
