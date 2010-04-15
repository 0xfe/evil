#!/bin/sh

# This script checks the status of the current git repo.

function parse_git_dirty {
  [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "(dirty)"
}

ref=$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)

if [ "$ref" != "" ]
then
  unpushed=`(git branch --no-color -r --contains HEAD; \
    git branch --no-color -r) | grep -v HEAD | sort | uniq -u`
  unmerged=$(git branch --no-color -a --no-merged | grep -v HEAD)
  stashed=$(git stash list)

  echo Current branch: $ref $(parse_git_dirty)

  if [ "$unpushed" != "" ]
  then
    echo Unpushed branches:
    echo $unpushed
    echo
  fi

  if [ "$unmerged" != "" ]
  then
    echo Unmerged branches:
    echo $unmerged
    echo
  fi

  echo
  if [ "$stashed" != "" ]
  then
    echo Stashed states:
    echo $stashed
    echo
  fi

  git diff --shortstat
fi
