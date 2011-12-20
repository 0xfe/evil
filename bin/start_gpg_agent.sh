#!/bin/bash
# source in this file to startup gpg-agent

eval $(gpg-agent --daemon --enable-ssh-support --write-env-file $HOME/.gpg-agent-info)
