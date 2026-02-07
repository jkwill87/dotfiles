-- Plugin declarations using vim.pack (Neovim 0.12+)
-- All plugins load as 'start' packages

local gh = 'https://github.com/'

vim.pack.add {
  -- Theme
  gh .. 'rebelot/kanagawa.nvim',

  -- UI
  gh .. 'romgrk/barbar.nvim',
  gh .. 'kyazdani42/nvim-web-devicons',
  gh .. 'yamatsum/nvim-cursorline',
  gh .. 'NvChad/nvim-colorizer.lua',

  -- Git
  gh .. 'lewis6991/gitsigns.nvim',

  -- Treesitter
  gh .. 'nvim-treesitter/nvim-treesitter',
  gh .. 'RRethy/nvim-treesitter-endwise',

  -- Fuzzy finder
  gh .. 'nvim-telescope/telescope.nvim',
  gh .. 'nvim-lua/plenary.nvim',
  gh .. 'nvim-telescope/telescope-file-browser.nvim',
  gh .. 'nvim-telescope/telescope-github.nvim',
  gh .. 'nvim-telescope/telescope-ui-select.nvim',

  -- LSP
  gh .. 'williamboman/mason.nvim',

  -- Copilot
  gh .. 'zbirenbaum/copilot.lua',

  -- Folding
  gh .. 'kevinhwang91/nvim-ufo',
  gh .. 'kevinhwang91/promise-async',
  gh .. 'luukvbaal/statuscol.nvim',

  -- Editing
  gh .. 'windwp/nvim-autopairs',
  gh .. 'kylechui/nvim-surround',
  gh .. 'andymass/vim-matchup',

  -- Session
  gh .. 'rmagatti/auto-session',

  -- Keymap hints
  gh .. 'folke/which-key.nvim',

  -- Commands
  gh .. 'tpope/vim-eunuch',

  -- Syntax
  gh .. 'MTDL9/vim-log-highlighting',
}

-- Rebuild treesitter parsers after plugin updates
vim.api.nvim_create_autocmd('User', {
  pattern = 'PackChanged',
  callback = function() vim.cmd('TSUpdate') end,
})
