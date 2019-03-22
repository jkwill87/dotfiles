#!/bin/sh

[ "$DISTRO" = arch ] || return

pacman() {
    case $1 in
        -S | -D | -S[!sih]* | -R* | -U*)
            /usr/bin/sudo /usr/bin/pacman "$@"
            ;;
        *) /usr/bin/pacman "$@" ;;
    esac
}

alias pacaur="pacaur --noedit"
