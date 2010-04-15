# bash includes.
# Mohit Cheppudira <mohit@muthanna.com>

# Returns "*" if the current git branch is dirty.
function parse_git_dirty {
  [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"
}

# Returns "|shashed:N" where N is the number of stashed states (if any).
function parse_git_stash {
  local stash=`expr $(git stash list 2>/dev/null| wc -l)`
  if [ "$stash" != "0" ]
  then
    echo "|stashed:$stash"
  fi
}

# Returns "|unmerged:N" where N is the number of unmerged branches (if any).
function parse_git_unmerged {
  local unmerged=`expr $((git branch --no-color -a --contains HEAD; git branch --no-color -a) | sort | uniq -u | wc -l)`
  if [ "$unmerged" != "0" ]
  then
    echo "|unmerged:$unmerged"
  fi
}

# Get the current git branch name (if available)
git_prompt() {
  local ref=$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)
  if [ "$ref" != "" ]
  then
    echo "($ref$(parse_git_dirty)$(parse_git_stash)$(parse_git_unmerged)) "
  fi
}

# A plain (colorless) prompt.
function plain_prompt
{
  local current_tty=`tty | sed -e "s/\/dev\/\(.*\)/\1/"`
  PS1="> $current_tty \u@\H:\w\n> \$? \t \! "'\$'" "
  PS2="> "
}

# A fancy colorful prompt
function color_prompt
{
  local none="\[\033[0m\]"

  local black="\[\033[0;30m\]"
  local dark_gray="\[\033[1;30m\]"
  local blue="\[\033[0;34m\]"
  local light_blue="\[\033[1;34m\]"
  local green="\[\033[0;32m\]"
  local light_green="\[\033[1;32m\]"
  local cyan="\[\033[0;36m\]"
  local light_cyan="\[\033[1;36m\]"
  local red="\[\033[0;31m\]"
  local light_red="\[\033[1;31m\]"
  local purple="\[\033[0;35m\]"
  local light_purple="\[\033[1;35m\]"
  local brown="\[\033[0;33m\]"
  local yellow="\[\033[1;33m\]"
  local light_gray="\[\033[0;37m\]"
  local white="\[\033[1;37m\]"

  local current_tty=`tty | sed -e "s/\/dev\/\(.*\)/\1/"`

  local u_color=$purple
  id -u > /dev/null 2>&1 &&           #Cross-platform hack.

  if [ `id -u` -eq 0 ] ; then
    local u_color=$yellow
  fi

  PS1="$light_blue> $current_tty $u_color\u$brown@${purple}\h$brown:$light_blue\w\n$light_blue> $light_red\$? $cyan\$(git_prompt)$brown"'\$'"$none "

  PS2="$dark_gray>$none "
}

function set_title
{
  # If this is an xterm set the title to user@host:dir
  case "$TERM" in
  xterm*|rxvt*)
      PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
      ;;
  *)
      ;;
  esac
}

function setup_aliases
{
  # Useful aliases
  alias ll='ls -l'
  alias stitle='screen -X title'
}

function setup_env
{
  # CDPATH makes life easier
  export CDPATH=.:..:../..:~

  # don't put duplicate lines in the history. See bash(1) for more options
  export HISTCONTROL=ignoredups
  # ... and ignore same sucessive entries.
  export HISTCONTROL=ignoreboth

  # check the window size after each command and, if necessary,
  # update the values of LINES and COLUMNS.
  shopt -s checkwinsize

  # make less more friendly for non-text input files, see lesspipe(1)
  [ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

  # Setup ls --color for black background.
  export LSCOLORS=Exfxcxdxbxegedabagacad

  # I'm a vi guy
  export EDITOR=vi
}

function setup_common
{
  # If not running interactively, don't do anything
  [ -z "$PS1" ] && return

  setup_aliases
  setup_env
  color_prompt
  set_title
}

function setup_mac
{
  alias ls='ls -G'
  export PATH=$HOME/Local/bin:/opt/local/bin:/usr/local/bin:/opt/local/sbin:$PATH
  setup_common
}

function setup_linux
{
  alias ls='ls --color'
  setup_common
}
