#!/bin/sh

[ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ] || return
[ -x "$HOME/.phpenv/bin/phpenv" ] && eval "$("$HOME"/.phpenv/bin/phpenv init -)"
