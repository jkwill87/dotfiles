#!/usr/bin/sh

# dirstack.sh
# jessy@jessywilliams.com

# ------------------------------------------------------------------------------

export DIRSTACK_FILE="$HOME/.dirstack"

# performs normal 'cd', but writes dirstack to a rotating file which is shared
# between terminals/sessions
cd() {
    builtin cd "$1" || return
    sed -i -e "\\:^$(pwd -L)\$:d" "$DIRSTACK_FILE"
    dirstack=$(pwd -L && head -n 8 "$DIRSTACK_FILE")
    echo "$dirstack" >"$DIRSTACK_FILE"
    unset dirstack
}

# type 'cdd' to get list of dirs
cdd() {
    if [ ! -s "$DIRSTACK_FILE" ]; then
        touch "$DIRSTACK_FILE"
        echo 'Dirstack empty :('
    elif [ $# -eq 0 ]; then
        # print dirstack entries when called w/o arguments
        if exists fzf; then
            cd $(cat ${HOME}/.dirstack | fzf --reverse)
        else
            line=1
            while read -r dirstack; do
                tput bold
                printf "  %s" $line
                tput sgr0
                echo ". $dirstack"
                line=$((line + 1))
            done </"$DIRSTACK_FILE"
        fi
    else
        line=$(printf "$1" | cut -c 1 | tr -d '[:alpha:]')
        line=${line:=0}
        lines=$(wc -l <"$DIRSTACK_FILE")
        if [ $line -le 0 ] || [ $line -ge 10 ] || [ $line -gt $lines ]; then
            # display usage if user enters incorrect parameters
            echo "usage: cdd [1-10]"
        else
            # get dirstack line corresponding with line number
            dirstack=$(sed -n "$line"p "$DIRSTACK_FILE")
            # cd to entry
            builtin cd "$dirstack" || return
            # move cdded directory to top of dirstack
            dirstack2=$(sed "$line"d "$DIRSTACK_FILE")
            echo "$dirstack" > "$DIRSTACK_FILE"
            echo "$dirstack2" >> "$DIRSTACK_FILE"
        fi
    fi
    unset line
    unset lines
    unset dirstack
    unset dirstack2
}
