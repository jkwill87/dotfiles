#!/bin/sh

if [ -x "$HOME/.pyenv/bin/pyenv" ]; then
    eval "$("$HOME"/.pyenv/bin/pyenv init -)"
    exists 'pyenv-virtualenv' && eval "$(pyenv virtualenv-init -)"
fi
