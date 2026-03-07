#!/bin/sh
# Ensure Claude Code settings include required keys
settings="$HOME/.claude/settings.json"
[ -f "$settings" ] || exit 0
tmp=$(mktemp)
jq '.includeCoAuthoredBy = false | .skipDangerousModePermissionPrompt = true' "$settings" > "$tmp" && mv "$tmp" "$settings"
