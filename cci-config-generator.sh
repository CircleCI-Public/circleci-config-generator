#!/bin/bash

# Script to generate a CircleCI 2.0 `.circleci/config.yml` file
# Please see the README for more details

echo -e "Gathering info please wait..."

# Get and set variables
circle_dir="./.circleci"
conf_file="./.circleci/config.yml"
vcs_provider="$(git remote -v | awk -F'[@.]' 'NR==1{ print $2 }')"
project="$(git remote -v | awk -F'[@:.]' 'NR==1{ print $4 }')"
test_branch="circleci-20-test"
remote_test_branch="$(git ls-remote git@"$vcs_provider".com:"${project}".git "$test_branch")"
local_test_branch="$(git branch -a | grep "$test_branch")"

# Read in API token
read -rp 'Paste your CircleCI API token here: ' circle_token

# Check if this is a GitHub or Bitbucket repo
if [ "$vcs_provider" != "github" ] && [ "$vcs_provider" != "bitbucket" ] ; then
  echo -e "CircleCI currently supports bitbucket and github only"
  exit
fi

# Set vcs_short variable
if [ "$vcs_provider" = "github" ]
  then
    vcs_short="gh"
fi

if [ "$vcs_provider" = "bitbucket" ]
  then
    vcs_short="bb"
fi

# Check if test branch exists on remote
if [ -n "$remote_test_branch" ]
  then
    echo -e "circleci-20-test branch already exists on remote - please delete it before continuing."
    exit
fi

# Check if branch exists locally and create it if not
if [ -z "$local_test_branch" ]
  then
    git checkout -b circleci-20-test && echo -e "Created circleci-20-test branch and switched to it."
  else
    echo -e "circleci-20-test branch already exists locally - please delete it before continuing."
    exit
fi

# Create .cirleci directory if it doesn't exist
if [ ! -d "$circle_dir" ]
  then
    mkdir "$circle_dir"
fi

# Create config.yml if it doesn't exist
if [ ! -d "$conf_file" ]
  then
    touch "$conf_file"
  else
    echo -e ".circleci/config.yml already exists. Please delete it before running this script again."
    exit
fi

# Generate config file from translation endpoint
echo -e "Generating config file via CircleCI API"
curl -X GET https://circleci.com/api/v1.1/project/"${vcs_provider}"/"${project}"/config-translation?circle-token="$circle_token"\&branch=circleci-20-test > $conf_file
echo -e "Config file written to .circleci/config.yml"

read -rp 'Would you like to commit this change and push the test branch to try the build on CircleCI? (y/n): ' choice

if [ "$choice" = "y" ]
  then
    git add "$conf_file"
    git commit -m "Adding auto-generated CircleCI 2.0 config file"
    git push origin circleci-20-test
    echo -e "Go to https://circleci.com/$vcs_short/$project to see the new build."
    echo -e "If it passes - congratulations, you're good to go. If it's red, please see the README for next steps."
  else
    echo -e "You can manually trigger a build on CircleCI by committing and pushing this branch to the remote."
    exit
fi
