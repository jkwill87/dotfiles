require('conform').setup {
  formatters_by_ft = {
    markdown = { 'prettier' },
    yaml = { 'prettier' },
    sh = { 'shfmt' },
    bash = { 'shfmt' },
    zsh = { 'shfmt' },
  },
}
