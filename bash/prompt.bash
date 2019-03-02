#!/bin/bash

# prompt.bash
# jessy@jessywilliams.com

# ------------------------------------------------------------------------------

# echo fortune if installed
if exists fortune; then
    fortune
    echo ''
fi

# set shell colours
if [[ $(tput colors 2>&1) == 256 ]]; then
    c_reset="\[$(tput sgr0)\]"
    c_warn="\[$(tput setaf 160)\]"
    c_host="\[$(tput setaf 39)\]"
    c_path="\[$(tput setaf 45)\]"
    c_vcs="\[$(tput setaf 51)\]"
    if [[ $(whoami) == 'root' ]]; then
        c_user="\[$(tput setaf 92)\]"
    else
        c_user="\[$(tput setaf 27)\]"
    fi
else
    c_reset='\033[0m'
    c_warn='\033[31m'
    c_host='\033[34m'
    c_path='\033[34'
    c_vcs='\033[36m'
    if [[ $(whoami) == 'root' ]]; then
        c_user='\033[31m'
    else
        c_user='\033[34m'
    fi
fi

# get ssh status (one level down, will not pass through su)
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    session='@'
else
    session='%'
fi

# get last command's exit code
get_sigil() {
    local retval=$?
    if [ $retval != 0 ]; then
        echo '!'
    else
        echo '\$'
    fi
}

# get git info
get_git() {
    local branch
    local status

    if branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null); then
        if [[ "$branch" == "HEAD" ]]; then
            branch='detached*'
        fi
        if [[ $(git status --porcelain 2>/dev/null) != "" ]]; then
            status='*'
        fi
        echo " <$branch$status>"
    fi
}

# format prompt
get_prompt() {
    local sigil=$(get_sigil) # must be first!
    local cwd='\W'
    local host='\h'
    local path='\w'
    local username='\u'
    local vcs=$(get_git)

    PS1=$c_user
    PS1+=$username

    PS1+=$c_host
    PS1+=$session
    PS1+=$host

    PS1+=$c_path
    PS1+=":$cwd"

    PS1+=$c_vcs
    PS1+=$vcs

    PS1+=$c_reset
    PS1+=" $sigil "
}

# instruct bash to reload prompt after each command
PROMPT_COMMAND=get_prompt

# write to bash history after every command, sharing between terminal windows
PROMPT_COMMAND="$PROMPT_COMMAND; history -a; history -c; history -r"

# start prompt in previous directory
# cdd 1
