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
map('n', '<Leader>[', '<Cmd>BufferPrevious<CR>', { desc = 'Previous buffer' })
map('n', '<Leader>]', '<Cmd>BufferNext<CR>', { desc = 'Next buffer' })
map('n', '<Leader>[[', '<Cmd>BufferMovePrevious<CR>', { desc = 'Move buffer left' })
map('n', '<Leader>]]', '<Cmd>BufferMoveNext<CR>', { desc = 'Move buffer right' })
for i = 1, 9 do
  map('n', '<Leader>' .. i, '<Cmd>BufferGoto ' .. i .. '<CR>', { desc = 'Go to buffer ' .. i })
end
-- Hide 2-9 from which-key; buffer 1 entry hints at the full range
local wk = require('which-key')
wk.add { { '<Leader>1', desc = 'Go to buffer 1-9' } }
for i = 2, 9 do
  wk.add { { '<Leader>' .. i, hidden = true } }
end
map('n', '<Leader>bn', '<Cmd>enew<CR>', { desc = 'New buffer' })
map('n', '<Leader>bd', function() Snacks.bufdelete() end, { desc = 'Delete buffer' })
map('n', '<Leader>bp', '<Cmd>BufferPin<CR>', { desc = 'Pin buffer' })
map('n', '<Leader>b=', '<Cmd>BufferCloseAllButCurrent<CR>', { desc = 'Close all but current buffer' })


-- LSP
map('n', '<Leader>f', function() require('conform').format { lsp_fallback = true } end, { desc = 'Format buffer' })

-- Which-key
map('n', '<Leader>?', function() require('which-key').show({ global = false }) end, { desc = 'Buffer Local Keymaps (which-key)' })
