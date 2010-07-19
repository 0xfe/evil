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

function setup_aliases
{
  # Useful aliases
  alias ll='ls -l'
  alias stitle='screen -X title'
}

function setup_gpg_agent
{
  if [ -f ${HOME}/.gpg-agent-info ]
  then
    source ${HOME}/.gpg-agent-info
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
    export SSH_AGENT_PID

    GPG_TTY=$(tty)
    export GPG_TTY
  fi
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

  # Add local scripts to path
  export PATH=$EVIL_HOME/bin:$PATH
}

# -----------------------------------------
# Add your local shared customizations here
# -----------------------------------------

function setup_common
{
  # If not running interactively, don't do anything
  [ -z "$PS1" ] && return

  setup_aliases
  setup_gpg_agent
  setup_env
  color_prompt
  set_title
}

