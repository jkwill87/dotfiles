-- Plugin declarations using vim.pack (Neovim 0.12+)
-- All plugins load as 'start' packages

local gh = 'https://github.com/'

vim.pack.add {
  -- Theme
  gh .. 'rebelot/kanagawa.nvim',

  -- UI
  gh .. 'romgrk/barbar.nvim',
  gh .. 'kyazdani42/nvim-web-devicons',
  gh .. 'NvChad/nvim-colorizer.lua',
  gh .. 'ya2s/nvim-cursorline',

  -- Git
  gh .. 'lewis6991/gitsigns.nvim',
  gh .. 'sindrets/diffview.nvim',

  -- Treesitter
  gh .. 'nvim-treesitter/nvim-treesitter',
  gh .. 'RRethy/nvim-treesitter-endwise',

  -- Snacks (picker, explorer, etc.)
  gh .. 'folke/snacks.nvim',

  -- LSP
  gh .. 'williamboman/mason.nvim',

  -- Copilot
  gh .. 'zbirenbaum/copilot.lua',

  -- Folding
  gh .. 'kevinhwang91/nvim-ufo',
  gh .. 'kevinhwang91/promise-async',

  -- Editing
  gh .. 'windwp/nvim-autopairs',
  gh .. 'kylechui/nvim-surround',
  gh .. 'andymass/vim-matchup',

  -- Session
  gh .. 'rmagatti/auto-session',

  -- Keymap hints
  gh .. 'folke/which-key.nvim',

  -- Formatting
  gh .. 'stevearc/conform.nvim',

  -- Commands
  gh .. 'tpope/vim-eunuch',

  -- Syntax
  gh .. 'MTDL9/vim-log-highlighting',
}

-- Rebuild treesitter parsers when nvim-treesitter itself changes
vim.api.nvim_create_autocmd('User', {
  pattern = 'PackChanged',
  callback = function(ev)
    local data = ev.data
    if data.spec.name ~= 'nvim-treesitter' then return end
    if data.kind == 'install' or data.kind == 'update' then
      vim.cmd('TSUpdate')
    end
  end,
})
