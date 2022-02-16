#!/usr/bin/env bash

# This script will be executed ON THE HOST when you connect to the host.
# Put here your functions, environment variables, aliases and whatever you need.

CURR_DIR="$(cd "$(dirname "$0")" && pwd)"
plugin_name='xxh-plugin-zsh-ripgrep'

export PATH=$CURR_DIR/ripgrep:$CURR_DIR/bat-extras/bin:$PATH
alias grep='batgrep'
fpath=($CURR_DIR/bat-extras/complete $fpath)