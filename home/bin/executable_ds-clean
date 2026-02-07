#!/bin/sh

# ds-clean: removes ds files from directory
# jessy@jessywilliams.com

# ------------------------------------------------------------------------------

[ $# -eq 0 ] && echo 'usage ds-clean PATHS' & exit
sudo find "$@" -name '.DS_Store' -type f -delete
