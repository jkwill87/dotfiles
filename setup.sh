#!/bin/sh
set -e

GITHUB_USER="jkwill87"
CHEZMOI_BIN="$HOME/bin"

# install chezmoi if missing
if ! command -v chezmoi >/dev/null 2>&1; then
    mkdir -p "$CHEZMOI_BIN"
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$CHEZMOI_BIN"
    export PATH="$CHEZMOI_BIN:$PATH"
fi

# init (first run) or update (subsequent runs)
if [ ! -d "$(chezmoi source-path 2>/dev/null)" ]; then
    chezmoi init --apply "$GITHUB_USER"
else
    chezmoi update
fi
