#!/bin/bash

# rc.bash
# jessy@jessywilliams.com

# ------------------------------------------------------------------------------

# If not running interactively, don't do anything else
[[ $- != *i* ]] && return

# only load once per session
[ -z "$_BASH_RC_LOADED" ] || [ -n "$_RELOAD_RC" ] || return
_BASH_RC_LOADED=1

# bash completions
bash_completion_path='/usr/share/bash-completion/bash_completion'
[ -f "$bash_completion_path" ] && source "$bash_completion_path"
if exists brew; then
    if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
        source "$(brew --prefix)/etc/bash_completion"
    fi
fi

# history
shopt -s histappend

# More lenient text expansion and globbing
shopt -s cdspell
shopt -s expand_aliases
shopt -s hostcomplete
shopt -s nocaseglob
shopt -s nocasematch

# source shell scripts
if [ -d $HOME/.config/shell ]; then
    for file in "$HOME"/.config/shell/*.sh; do
        source "$file"
    done
    unset file
fi

# source bash scripts
if [ -n "$BASH_VERSION" ] && [ -d $HOME/.config/bash ]; then
    for file in "$HOME"/.config/bash/*.bash; do
        source "$file"
    done
    unset file
fi
