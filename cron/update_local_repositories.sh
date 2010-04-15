#!/bin/sh

# This script updates all local repositories by running "git fetch" on
# them. Ideally, this is run with the git shell-prompt customizations
# in ~/s/dotfiles/scripts/prompt.sh such that the user is made aware of
# new data in a remote repo.
#
# Add this script to your crontab. For example:
#
# 0,15,30,45 * * * * ~/s/cron/update_local_repositories.sh >/dev/null 2>&1

for dir in `cat ~/s/GIT.conf`
do
  spath=~/$dir
  if [ -d $spath ]
  then
    echo "Updating $spath..."
    cd $spath
    git fetch
  fi
done
