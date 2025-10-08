# Colors
set -l default $(tput sgr0)
set -l red $(tput setaf 1)
set -l green $(tput setaf 2)
set -l purple $(tput setaf 5)
set -l orange $(tput setaf 9)

# Less colors for man pages
set -xg PAGER less
# Begin blinking
set -xg LESS_TERMCAP_mb $red
# Begin bold
set -xg LESS_TERMCAP_md $orange
# End mode
set -xg LESS_TERMCAP_me $default
# End standout-mode
set -xg LESS_TERMCAP_se $default
# Begin standout-mode - info box
set -xg LESS_TERMCAP_so $purple
# End underline
set -xg LESS_TERMCAP_ue $default
# Begin underline
set -xg LESS_TERMCAP_us $green
