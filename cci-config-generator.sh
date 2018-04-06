#!/bin/bash

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

echo -e "Go to your project on CircleCI and copy the URL to your project\nThe URL will be in the format https://circleci.com/vcs-provider/org/project"
read url

plat="$(echo "$url" | awk -F"/" '{ print $4 }')"
org="$(echo "$url" | awk -F"/" '{ print $5 }')"
proj="$(echo "$url" | awk -F"/" '{ print $6 }')"

if [ "$plat" == "gh" ]
	then
		pl="github"
elif [ "$plat" == "bb" ]
	then
		pl="bitbucket"
else
	echo -e "CircleCI currently supports bitbucket and github only"
fi

branch="$(git ls-remote https://github.com/"${org}"/"${proj}".git circleci-20-test)"

if [ -z "$branch" ]
        then
                git checkout -b circleci-20-test
fi

curl -X GET "https://circleci.com/api/v1.1/project/"${pl}"/"${org}"/"${proj}"/config-translation?circle-token=$CIRCLE_TOKEN&branch=circleci-20-test" > "$yaml"
echo -e "You can now enter the following commands in order to test your build on CircleCI 2.0\ngit add "$circdir"\ngit commit -m \"Testing script-generated config.yml\"\ngit push origin circleci-20-test"
