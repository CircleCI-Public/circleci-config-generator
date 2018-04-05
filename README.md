# Circleci Config Generator

The repo contains a shell script to generate a basic configuration file for CircleCI 2.0

---

## NOTE: WIP - do not use until this notice has been removed.

---

## Reason to use this

If a project (git repo) is connected to CircleCI and has no `circle.yml` (for CircleCI 1.0) or `.circleci/config.yml` (for CircleCI 2.0) file, CircleCI will try to build on CircleCI 1.0 using 'inference' (we inspect the files and 'infer' what tests to run).

CircleCI 1.0 will be EOL soon (https://circleci.com/sunset1-0/). So all projects will need a `.circleci/config.yml` file to build on 2.0.

This script is helpful if you're building on 1.0 without a config file (you do not have a `circle.yml` file at the root of your project). It will help you get started on CircleCI 2.0.

Running this script locally from the root of your project will:

1. Generate a `.circleci/config.yml` file
2. Create a new Git branch called `circleci-20-test`
3. Push a new commit on that branch and build it on CircleCI 2.0
4. Give you a link so you can see if the new build was successful on CircleCI 2.0

## Requirements

You will need:

1. Git and Curl installedon on your local computer
2. project checked out on your local computer
3. push access to your GitHub or Bitbucket repo
4. a CircleCI API token (see below)

This script makes use of the CircleCI 'config translation' tool which is documented here:
https://circleci.com/docs/2.0/config-translation/

## How to use

1. Create an API token in the CircleCI UI: https://circleci.com/account/api
2. Copy the API token and make it available as an environment variable on your local computer in the current shell: `CIRCLE_TOKEN='YOUR-TOKEN-HERE'`
3. Download this script https://github.com/CircleCI-Public/circleci-config-generator/blob/master/cci-config-generator.sh
4. Make sure the script is in the root of your project
5. Make the script executable: `chmod +x cci-config-generator.sh`
6. Run the script `./cci-config-generator.sh`
7. The script will ask you for the link to the project on CircleCI in the form: `https://circleci.com/gh/ORG/REPO` (note that `gh` might be `bb` if you're building on Bitbucket. We recommend copying and pasting the link from your project on CircleCI).
8. The script will generate the config, create a branch and kick off a build
9. `TODO - Optional` Follow the link to see if the build completed successfully

If you're build is green - congratulations you can now build on CircleCI 2.0.

It it's red, you can troubleshoot any error messages using our docs: https://circleci.com/docs/2.0/

If you need more help, please open a support ticket here: https://support.circleci.com/hc/en-us/requests/new

