#!/bin/zsh

# rc.zsh
# jessy@jessywilliams.com

# ------------------------------------------------------------------------------

# If not running interactively, don't do anything else
[[ $- != *i* ]] && return

# only load once per session
[ -z "$_ZSH_RC_LOADED" ] || [ -n "$_RELOAD_RC" ] || return
_ZSH_RC_LOADED=1

# emacs-like key binding
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

# autocorrect
setopt correctall
SPROMPT="Correct $fg[blue]%R$reset_color to $fg[blue]%r?$reset_color [y/n/e/a] "

# autocomplete
autoload -U compinit
compinit -u
zstyle ':completion:*' menu select

# history
setopt nosharehistory
setopt incappendhistory
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS

# source shell files
if [ -d "$HOME"/.config/shell ]; then
    for file in "$HOME"/.config/shell/*.sh; do
        source "$file"
    done
    unset file
fi

# source zsh files
if [ -n "$ZSH_VERSION" ] && [ -d $HOME/.config/zsh ]; then
    for file in "$HOME"/.config/zsh/*.zsh; do
        source "$file"
    done
    unset file
fi
