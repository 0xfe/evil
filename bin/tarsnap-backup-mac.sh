#!/bin/bash
/Users/mmuthanna/homebrew/bin/tarsnap -c -f "$(uname -n)-$(date +%Y-%m-%d_%H-%M-%S)" $* /Users/mmuthanna
