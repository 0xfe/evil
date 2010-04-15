# Evil Tomato Configuration
# Mohit Muthanna <mohit@muthanna.com>
#
# Source this into your login script. (If you're using the dotfiles/bashrc
# include, then it does this for you automatically.)

EVIL_HOME=$HOME/c

# List out the repositories managed here. At a minimum you need the Evil
# Tomato repo here (EVIL_HOME).
EVIL_REPO_DIRS="$EVIL_HOME $HOME/x $HOME/w $HOME/p"

export EVIL_HOME EVIL_REPO_DIRS
