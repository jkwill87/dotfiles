#!/bin/bash

function nvx() {
    # php
    [ -x "$HOME/.phpenv/bin/phpenv" ] && eval "$("$HOME"/.phpenv/bin/phpenv init -)"

    # node
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

    # python
    if [ -x "$HOME/.pyenv/bin/pyenv" ]; then
        export PATH="$HOME/.pyenv/bin:$PATH"
    fi
    if exists 'pyenv'; then
        eval "$(pyenv init -)"
        exists 'pyenv-virtualenv' && eval "$(pyenv virtualenv-init -)"
    fi

    # ruby
    exists 'rbenv' && eval "$(rbenv init -)"
}
