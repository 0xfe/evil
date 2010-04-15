#!/bin/bash

# This script updates all local repositories by running "git fetch" on
# them. Ideally, this is run with the git shell-prompt customizations
# in ~/s/dotfiles/scripts/prompt.sh such that the user is made aware of
# new data in a remote repo.
#
# You need to ensure that you SSH public keys are available to the relevant
# git servers (to allow for non-interactive updates).
#
# Add this script to your crontab. For example:
#
# 0,15,30,45 * * * * ~/s/cron/update_local_repositories.sh >/dev/null 2>&1

source $EVIL_HOME/env.sh

for dir in $EVIL_REPO_DIRS
do
  echo "Checking for $dir..."
  if [ -d $dir ]
  then
    echo "Updating $dir..."
    cd $dir
    git fetch
  fi
done
