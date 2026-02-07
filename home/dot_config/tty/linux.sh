#!/bin/sh

# xclip: provide macOS-like pbcopy/pbpaste aliases
if command -v xclip >/dev/null 2>&1; then
    alias pbcopy="xclip -selection clipboard"
    alias pbpaste="xclip -selection clipboard -o"
fi
