$env.config.buffer_editor = "nvim"
$env.config.show_banner = false

$env.LS_COLORS = "di=1:ln=36:so=36:pi=36:ex=35:bd=37;44:cd=34:su=34:sg=34:tw=1;1:ow=1"

# aliases
alias ll = ls -l

# setup mise
use ($nu.default-config-dir | path join mise.nu)

# setup zoxide
source ~/.zoxide.nu

# setup carapace
source ~/.cache/carapace/init.nu
