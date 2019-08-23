# Include file for your local bashrc.
# Mohit Cheppudira <mohit@muthanna.com>
#
# EVIL_HOME needs to be defined before you source in this file. You can do this
# by sourcing in env.sh before including this script
#
#   source ~c/env.sh
#   source $EVIL_HOME/dotfiles/bashrc.include.sh

# Include prompt support functions.
source $EVIL_HOME/dotfiles/scripts/prompt.sh

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

function setup_globals
{
  # Useful aliases
  OS=`uname`
  if [[ "$OS" == "Linux" ]]; then
    alias ls='ls --color'
    export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
  elif [[ "$OS" == "Darwin" ]]; then
    alias ls='ls -G'
    export JAVA_HOME=`/usr/libexec/java_home`
  fi

  alias ll='ls -l'
}

function setup_gpg_agent
{
  export GPG_TTY=$(tty)
  local gpg_conf=$(which gpgconf)
  ${gpg_conf} --launch gpg-agent
}

function setup_env
{
  # CDPATH makes life easier
  export CDPATH=.:..:../..:~:~/git:~/git/quid

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

  # Add local scripts to path
  export PATH=$EVIL_HOME/bin:$PATH

  # Golang
  export GOPATH=~/golang

  # Bash completion
  [ -f /Users/mmuthanna/homebrew/etc/bash_completion ] && . /Users/mmuthanna/homebrew/etc/bash_completion
}

# -----------------------------------------
# Add your local shared customizations here
# -----------------------------------------

function setup_common
{
  # If not running interactively, don't do anything
  [ -z "$PS1" ] && return

  setup_globals
  setup_gpg_agent
  setup_env
  color_prompt
  set_title
}

