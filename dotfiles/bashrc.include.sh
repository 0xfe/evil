# bash includes.
# Mohit Cheppudira <mohit@muthanna.com>

# Include prompt support functions
. ~/s/dotfiles/scripts/prompt.sh

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
