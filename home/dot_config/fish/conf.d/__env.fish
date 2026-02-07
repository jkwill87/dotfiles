if type -q nvim
    set -gx EDITOR nvim
else
    set -gx EDITOR vi
end

test -d $HOME/Sync; and set -gx SYNC $HOME/Sync
test -d $SYNC/Development; and set -gx DEV $SYNC/Development
test -d $DEV/dotfiles; and set -gx DOT $DEV/dotfiles
