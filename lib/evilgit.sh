# Git support functions for Evil Tomato
# Mohit Cheppudira <mohit@muthanna.com>

# Returns "*" if the current git branch is dirty.
function evil_git_dirty {
  [[ $(git diff --shortstat 2>/dev/null | tail -n1) != "" ]] && echo "*"
}

# Returns the number of untracked files.
function evil_git_num_untracked_files {
  expr `git status --porcelain 2>/dev/null| grep "^??" | wc -l`
}

# Returns the number of untracked files.
function evil_git_num_dirty_files {
  expr `git status --porcelain 2>/dev/null | egrep "^(M| M)" | wc -l`
}

# Returns "|shashed:N" where N is the number of stashed states (if any).
function evil_git_stash {
  local stash=`expr $(git stash list 2>/dev/null| wc -l)`
  if [ "$stash" != "0" ]
  then
    echo "|stashed:$stash"
  fi
}

# List unmerged local and remote branches
function evil_git_list_unmerged {
  git branch --no-color -a --no-merged
}

# Returns "|unmerged:N" where N is the number of unmerged local and remote
# branches (if any).
function evil_git_unmerged {
  local unmerged=`expr $(evil_git_list_unmerged | grep -v HEAD | wc -l)`
  if [ "$unmerged" != "0" ]
  then
    echo "|unmerged:$unmerged"
  fi
}

# List unpushed commits on all branches
function evil_git_list_unpushed {
  git log --branches --not --remotes --simplify-by-decoration \
    --decorate --oneline
}

# Returns "|unpushed:N" where N is the number of unpushed local and remote
# branches (if any).
function evil_git_unpushed {
local unpushed=`expr $( evil_git_list_unpushed | wc -l )`

  if [ "$unpushed" != "0" ]
  then
    echo "|unpushed:$unpushed"
  fi
}

# Get the current git branch name (if available)
evil_git_prompt() {
  # local ref=$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)
  local ref=$(git branch 2>/dev/null | grep '^\*' | cut -b 3- | sed 's/[\(\)]//g')

  if [ "$ref" != "" ]
  then
    echo "($ref$(evil_git_dirty)$(evil_git_stash)$(evil_git_unmerged)$(evil_git_unpushed)) "
  fi
}
