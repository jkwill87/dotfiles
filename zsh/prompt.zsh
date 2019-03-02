#!/bin/zsh

# Set prompt
autoload -U colors promptinit
colors
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_STATESEPARATOR=''
function precmd() { PROMPT="%(#~%F{92}~%F{27})%n%F{39}@%m%F{45}:%c%f %F{51}$(__git_ps1 "<%s> ")%f%(#~%#~$) "; }

# echo fortune if installed
if exists fortune; then
    fortune
    echo ''
fi
