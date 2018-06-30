# Circleci Config Generator

The repo contains a shell script to generate a basic configuration file for CircleCI 2.0

## Reason to use this

If a project (git repo) is connected to CircleCI and has no `circle.yml` (for CircleCI 1.0) or `.circleci/config.yml` (for CircleCI 2.0) file, CircleCI will try to build on CircleCI 1.0 using 'inference' (we inspect the files and 'infer' what tests to run).

CircleCI 1.0 will be EOL soon (https://circleci.com/sunset1-0/). So all projects will need a `.circleci/config.yml` file to build on 2.0.

This script is helpful if you're building on 1.0 without a config file (you do not have a `circle.yml` file at the root of your project). It will help you get started on CircleCI 2.0.

Running this script locally from the root of your project will:

1. Create a new Git branch called `circleci-20-test` and check out that branch
2. Generate a `.circleci/config.yml` file in the new branch
3. Optionally push a new commit on that branch and build it on CircleCI 2.0

## Requirements

You will need:

1. Git and Curl installed on your local computer
2. Project checked out on your local computer
3. Push access to your GitHub or Bitbucket repo
4. A CircleCI API token (see below)

This script makes use of the CircleCI 'config translation' tool which is documented here:
https://circleci.com/docs/2.0/config-translation/

## How to use

1. Download this script https://github.com/CircleCI-Public/circleci-config-generator/blob/master/cci-config-generator.sh
2. Make sure the script is in the root of your project
3. Make the script executable: `chmod +x cci-config-generator.sh`
4. Create an API token in the CircleCI UI: https://circleci.com/account/api
5. Copy the API token to your clipboard
4. Run the script `./cci-config-generator.sh`
5. Paste in your API token when prompted
6. The script will generate the config, and optionally create a branch and kick off a build

## Did it work? Next steps

Visit your project page on CircleCI `https://circleci.com/gh/ORG/REPO` to see the new build that ran on CircleCI 2.0

If your build is green - congratulations you're now using CircleCI 2.0. Read the docs to take advantage of more CircleCI 2.0 features: https://circleci.com/docs/2.0/

It the build is red, you can troubleshoot any error messages using our docs: https://circleci.com/docs/2.0/

If you need more help, please open a support ticket here: https://support.circleci.com/hc/en-us/requests/new

