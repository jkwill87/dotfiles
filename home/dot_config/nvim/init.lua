-- Neovim 0.12+ configuration using vim.pack

-- Disable built-in plugins
local disabled_builtins = {
  'gzip',
  'matchit',
  'matchparen',
  'netrwPlugin',
  'tarPlugin',
  'tohtml',
  'tutor',
  'zipPlugin',
}
local disabled_providers = { 'perl', 'ruby' }
for _, provider in ipairs(disabled_providers) do
  vim.g['loaded_' .. provider .. '_provider'] = 0
end
for _, plugin in ipairs(disabled_builtins) do
  vim.g['loaded_' .. plugin] = 1
end

-- Plugins
require('packs')
vim.cmd.colorscheme('kanagawa')

-- Core settings
require('options')

-- Plugin configurations
require('plugins.barbar')
require('plugins.treesitter')
require('plugins.telescope')
require('plugins.ufo')
require('plugins.lsp')
require('plugins.copilot')

-- Inline plugin setups (no custom config needed)
require('gitsigns').setup()
require('nvim-autopairs').setup()
require('nvim-surround').setup()
require('mason').setup { ui = { check_outdated_packages_on_open = false } }

require('auto-session').setup {
  log_level = 'error',
  suppressed_dirs = { '~/' },
}

require('nvim-cursorline').setup {
  cursorline = { enable = false },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  },
}

vim.o.timeout = true
vim.o.timeoutlen = 300
require('which-key').setup()

-- Keymaps and autocmds (loaded last so all plugins are available)
require('keymaps')
require('autocmds')
