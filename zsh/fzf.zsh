#!/bin/zsh

# Setup fzf
[[ "$PATH" == *$HOME/.fzf/bin* ]] || path+=("$HOME/.fzf/bin")

# Auto-completion
[ -r "$HOME/.fzf/shell/completion.zsh" ] && source "$HOME/.fzf/shell/completion.zsh"

# Key bindings
[ -r "$HOME/.fzf/shell/key-bindings.zsh" ] && source "$HOME/.fzf/shell/key-bindings.zsh"
