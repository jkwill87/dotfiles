#!/bin/bash

SCRIPTS_DIR="${HOME}/.config/tmux/"
source "$SCRIPTS_DIR/yank_helpers.bash"

pane_current_path() {
    tmux display -p -F "#{pane_current_path}"
}

display_notice() {
    display_message 'PWD copied to clipboard!'
}

main() {
    local copy_command
    copy_command="$(clipboard_copy_command)"
    # $copy_command below should not be quoted
    pane_current_path | tr -d '\n' | $copy_command
    display_notice
}
main
