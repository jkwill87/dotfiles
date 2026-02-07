#!/bin/sh

# add brew to path if installed
if [ -x '/usr/local/bin/brew' ]; then
  brew_prefix='/usr/local'
elif [ -x '/opt/homebrew/bin/brew' ]; then
  brew_prefix='/opt/homebrew'
fi

if [ -n "$brew_prefix" ]; then
  export PATH="$brew_prefix/bin:$brew_prefix/sbin:$PATH"
fi
