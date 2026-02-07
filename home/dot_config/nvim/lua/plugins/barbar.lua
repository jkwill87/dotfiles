require('barbar').setup {
  animation = true,
  auto_hide = false,
  clickable = true,
  maximum_padding = 4,
  maximum_length = 30,
  semantic_letters = true,
  icons = {
    button = '',
    separator = { left = '▎' },
    inactive = { separator = { left = '▎' } },
    modified = { button = '*' },
    pinned = { button = '車' },
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true, icon = 'ﬀ' },
      [vim.diagnostic.severity.WARN] = { enabled = false },
      [vim.diagnostic.severity.INFO] = { enabled = false },
      [vim.diagnostic.severity.HINT] = { enabled = false },
    },
  },
}
