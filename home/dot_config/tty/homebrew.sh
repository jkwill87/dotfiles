#!/bin/sh

# add brew to path if installed
if [ -x '/usr/local/bin/brew' ]; then
  brew_prefix='/usr/local'
elif [ -x '/opt/homebrew/bin/brew' ]; then
  brew_prefix='/opt/homebrew'
fi

if [ -n "$brew_prefix" ]; then
  export PATH="$brew_prefix/bin:$brew_prefix/sbin:$PATH"

  # bash completions
  if [ -n "$BASH_VERSION" ] && [ -f "$brew_prefix/etc/bash_completion" ]; then
    . "$brew_prefix/etc/bash_completion"
  fi

  # zsh completions
  if [ -n "$ZSH_VERSION" ] && [ -d "$brew_prefix/share/zsh-completions" ]; then
    fpath+=("$brew_prefix/share/zsh-completions")
  fi
fi
