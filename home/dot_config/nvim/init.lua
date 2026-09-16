-- Neovim 0.12 or later configuration using vim.pack

-- Disable built-in plugins
local disabled_builtins = {
  'gzip',
  'matchit',
  'matchparen',
  'netrwPlugin',
  'tarPlugin',
  'tutor',
  'zipPlugin',
}
local disabled_providers = { 'node', 'perl', 'ruby' }
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
require('plugins.snacks')
require('plugins.lsp')
require('plugins.conform')

-- Inline plugin setups (no custom config needed)
require('gitsigns').setup()
require('nvim-autopairs').setup()
require('nvim-surround').setup()
require('nvim-cursorline').setup {
  disable_filetypes = {},
  disable_buftypes = {},
  cursorline = {
    enable = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  }
}

require('mason').setup { ui = { check_outdated_packages_on_open = false } }

local mason_ensure_installed = {
  'copilot-language-server',
  'fish-lsp',
  'json-lsp',
  'lua-language-server',
  'marksman',
  'prettier',
  'rust-analyzer',
  'shellcheck',
  'shfmt',
  'tombi',
  'typescript-language-server',
  'yaml-language-server',
}
local registry = require('mason-registry')
registry.refresh(function()
  for _, name in ipairs(mason_ensure_installed) do
    local ok, pkg = pcall(registry.get_package, name)
    if not ok then
      vim.notify('mason: unknown package ' .. name, vim.log.levels.WARN)
    elseif not pkg:is_installed() then
      pkg:install():once('closed', function()
        if not pkg:is_installed() then
          vim.notify('mason: failed to install ' .. name, vim.log.levels.ERROR)
        end
      end)
    end
  end
end)

require('auto-session').setup {
  log_level = 'error',
  suppressed_dirs = { '~/' },
}

vim.o.timeout = true
vim.o.timeoutlen = 300
require('which-key').setup()

-- Keymaps and autocmds (loaded last so all plugins are available)
require('keymaps')
require('autocmds')
