#!/bin/sh

# To add this to your git workflow:
#
# $ git config --global diff.external ~/c/bin/gitdiff.sh

# diff is called by git with 7 parameters:
# path old-file old-hex old-mode new-file new-hex new-mode

/usr/bin/opendiff "$2" "$5" | cat
