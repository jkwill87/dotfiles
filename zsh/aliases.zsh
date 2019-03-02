#!/bin/zsh

# urls
if [[ -n "$BROWSER" ]]; then
    _browser_fts=(htm html de org net com at cx nl se dk)
    for ft in $_browser_fts; do
        alias -s $ft=$BROWSER
    done
fi

# documents
alias -s txt=less
alias -s csv=less
alias -s json=less

# archives
alias -s zip="unzip -l"
alias -s rar="unrar l"
alias -s tar="tar tf"
alias -s tar.gz="echo "
alias -s ace="unace l"
