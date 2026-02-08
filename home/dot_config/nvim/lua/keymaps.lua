local map = vim.keymap.set

-- Command-line
map('c', '<C-a>', '<Home>', { desc = 'Move to beginning of line' })
map('c', '<C-e>', '<End>', { desc = 'Move to end of line' })

-- Splits
map('n', '<C-=>', '<Cmd>only<CR>', { desc = 'Close all other windows' })
map('n', '<C-->', '<Cmd>split<CR>', { desc = 'Split horizontally' })
map('n', '<C-\\>', '<Cmd>vsplit<CR>', { desc = 'Split vertically' })

-- Gutter
map('n', '<Leader>n', '<Cmd>set nu! rnu!<CR>', { desc = 'Toggle line numbers' })

-- Terminal
map('n', '<Leader>t', '<Cmd>terminal<CR>', { desc = 'Open terminal' })
map('t', '<Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

-- Buffer management (barbar)
map('n', '<C-q>', '<Cmd>BufferClose<CR>', { desc = 'Close buffer' })
map('n', '<Leader>[', '<Cmd>BufferPrevious<CR>', { desc = 'Previous buffer' })
map('n', '<Leader>]', '<Cmd>BufferNext<CR>', { desc = 'Next buffer' })
map('n', '<Leader>[[', '<Cmd>BufferMovePrevious<CR>', { desc = 'Move buffer left' })
map('n', '<Leader>]]', '<Cmd>BufferMoveNext<CR>', { desc = 'Move buffer right' })
for i = 1, 9 do
  map('n', '<Leader>' .. i, '<Cmd>BufferGoto ' .. i .. '<CR>', { desc = 'Go to buffer ' .. i })
end
map('n', '<Leader>bp', '<Cmd>BufferPin<CR>', { desc = 'Pin buffer' })
map('n', '<Leader>b=', '<Cmd>BufferCloseAllButPinned<CR>', { desc = 'Close unpinned buffers' })
map('n', '<A-Space>', '<Cmd>BufferPick<CR>', { desc = 'Pick buffer' })

-- LSP
map('n', '<Leader>f', vim.lsp.buf.format, { desc = 'Format buffer' })
