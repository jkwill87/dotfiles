export HISTFILESIZE=1000000
export HISTFILE="$HOME/.history"
export HISTSIZE=$HISTFILESIZE
export SAVEHIST=$HISTFILESIZE
export HISTIGNORE='cd *:cdd *'
export HISTCONTROL="ignoreboth"
touch "$HISTFILE"
