#!/bin/sh

# ls
if [ "$PLATFORM" = linux ] || [ -n "$COREUTILS" ]; then
    alias ls="LC_COLLATE=C ls -Nhq --group-directories-first --color=always"
fi

alias lsa="ls -Fla"

# cd
alias ..="cd .." # ".." to move up to the parent directory
alias ~="cd ~"   # '~' to move to the home directory

# network
alias ping="ping -c 3"
alias flush_dns="nscd -K && nscd"

# editor
command -v nvim >/dev/null 2>&1 && alias vim='nvim'

# git
alias gl="git log --pretty=oneline --no-merges --abbrev-commit"
alias ga="git commit --amend --no-edit"

# clear screen and scrollback
alias clear!="clear && printf '\e[3J'"
