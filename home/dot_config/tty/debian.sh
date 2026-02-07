#!/bin/sh

# On Debian/Ubuntu, fd is packaged as fdfind
if command -v fdfind >/dev/null 2>&1; then
    alias fd='fdfind'
fi
