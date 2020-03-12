#!/bin/zsh

# rc.zsh
# jessy@jessywilliams.com

# ------------------------------------------------------------------------------

# if not running interactively, don't do anything else
[[ $- != *i* ]] && return

# only load once per session
[ -z "$_ZSH_RC_LOADED" ] || [ -n "$_RELOAD_RC" ] || return
_ZSH_RC_LOADED=1

# key binding
bindkey -e
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[6~" down-line-or-history
bindkey "^[[5~" up-line-or-history
bindkey "^[[4~" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1~" beginning-of-line
bindkey '^[[B' history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^ ' autosuggest-execute

# zsh completions
zsh_completion_path='/usr/local/share/zsh-completions'
[ -d "$zsh_completion_path" ] && fpath+=("$zsh_completion_path")
setopt correctall
SPROMPT="Correct $fg[blue]%R$reset_color to $fg[blue]%r?$reset_color [y/n/e/a] "
alias sudo='nocorrect sudo'

# autocomplete

autoload -U compinit
compinit -u
zstyle ':completion:*' menu select

# history
setopt incappendhistory

# fzf
[ -r "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# http
if [[ -n "$BROWSER" ]]; then
    _browser_fts=(htm html de org net com dev)
    for ft in $_browser_fts; do
        alias -s $ft=$BROWSER
    done
fi

# documents
alias -s txt=less
alias -s csv=less
alias -s json=less

# archives
alias -s zip="unzip -l"
alias -s rar="unrar l"
alias -s tar="tar tf"
alias -s tar.gz="echo "
alias -s ace="unace l"

# source shell scripts
if [ -d $HOME/.config/tty ]; then
    for file in "$HOME"/.config/tty/*.{sh,bash,zsh}; do
        source "$file"
    done
    unset file
fi

# prompt
function precmd() {
    if [ ! -z $VIRTUAL_ENV ]; then
        local vdir="%F{220}[$(basename $(realpath $VIRTUAL_ENV/..))] "
    fi
    PROMPT="
%(#~%F{92}~%F{27})%n%F{39}@%m%F{45}:%c%f%F{51}$(_get_git) ${vdir}
%f%(#~%#~$) "
}
autoload -Uz colors promptinit
colors

# fortune
if exists 'fortune'; then
    fortune
    echo
fi
