-- Behaviour
vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.errorbells = false
vim.o.showmode = false
vim.o.smartcase = true

-- Undo history
vim.o.undodir = vim.fn.stdpath('cache') .. '/undodir'
vim.o.undofile = true

-- Indenting
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.signcolumn = 'yes'

-- Ruler
vim.o.wrap = false
vim.o.colorcolumn = '81,101,121'

-- Mouse
vim.o.mouse = 'a'

-- File handling
vim.o.swapfile = false
vim.o.writebackup = false
vim.o.backup = false
vim.o.modelines = 1

-- Searching
vim.o.showmatch = true

-- Splits
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.splitkeep = 'screen'

-- Folding via LSP, falling back to treesitter. Folds start closed-capable but
-- disabled, so `zi` turns them on.
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'
vim.o.foldenable = false
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldcolumn = '1'
vim.o.fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:▶]]

-- Whitespace rendering
vim.opt.listchars = {
  tab = '>>',
  trail = '~',
  nbsp = '␣',
}
vim.o.list = true

-- Sessions
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
