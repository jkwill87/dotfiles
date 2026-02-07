#!/bin/sh

# git-redate: changes the git commit date for a given hash
# jessy@jessywilliams.com

# ------------------------------------------------------------------------------

sha=$1
date=$(date --date="$2")
git filter-branch --env-filter \
    "if test \$GIT_COMMIT = '$sha'
then
    export GIT_AUTHOR_DATE='$date'
    export GIT_COMMITTER_DATE='$date'
fi" && rm -fr "$(git rev-parse --git-dir)/refs/original/"
