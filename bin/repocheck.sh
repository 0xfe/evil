#!/bin/sh

# This script checks the status of all repos configured in GIT.conf.

. ~/s/dotfiles/scripts/prompt.sh

OLDDIR=`pwd`

for dir in `cat ~/s/GIT.conf`
do
  spath=~/$dir
  if [ -d $spath ]
  then
    cd $spath
    echo $spath: $(git_prompt)
  fi
done

cd $OLDDIR
