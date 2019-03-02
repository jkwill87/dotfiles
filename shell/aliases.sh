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

# xclip
if exists 'xclip'; then
    alias pbcopy="xclip -selection clipboard"
    alias pbpaste="xclip -selection clipboard -o"
fi
