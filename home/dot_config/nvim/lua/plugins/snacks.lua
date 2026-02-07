require('snacks').setup {
  words = { enabled = true },
  statuscolumn = { enabled = true },
  notifier = { enabled = true },
  input = { enabled = true },
  scroll = { enabled = true },
  git = { enabled = true },
  picker = {
    sources = {
      files = {
        layout = { preset = 'dropdown', preview = false },
      },
      buffers = {
        layout = { preset = 'dropdown', preview = false },
        current = false,
        sort_lastused = true,
        win = {
          input = { keys = { ['<C-d>'] = { 'bufdelete', mode = { 'n', 'i' } } } },
        },
      },
      recent = {
        layout = { preset = 'dropdown', preview = false },
        filter = { cwd = true },
      },
      lines = {
        layout = { preset = 'dropdown', preview = false },
      },
      grep = {
        layout = { preset = 'ivy' },
      },
      explorer = {
        layout = { preset = 'ivy' },
      },
      select = {
        layout = { preset = 'select' },
      },
    },
  },
}

-- Keymaps — preserved from telescope
local map = vim.keymap.set
map('n', '<Leader><Leader>', function() Snacks.picker.files() end, { desc = 'Find files' })
map('n', '<Leader>g', function() Snacks.picker.grep() end, { desc = 'Live grep' })
map('n', '<Leader>b', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
map('n', '<Leader>c', function() Snacks.picker.git_log() end, { desc = 'Git log' })
map('n', '<Leader>j', function() Snacks.picker.jumps() end, { desc = 'Jumplist' })
map('n', '<C-f>', function() Snacks.picker.lines() end, { desc = 'Buffer search' })
map('n', '<Leader>e', function() Snacks.picker.explorer() end, { desc = 'File browser' })

-- New useful pickers
map('n', '<Leader>r', function() Snacks.picker.recent() end, { desc = 'Recent files' })
map('n', '<Leader>d', function() Snacks.picker.diagnostics() end, { desc = 'Diagnostics' })
map('n', '<Leader>s', function() Snacks.picker.grep_word() end, { desc = 'Grep word under cursor' })
map('n', '<Leader>u', function() Snacks.picker.undo() end, { desc = 'Undo history' })
map('n', '<Leader>/', function() Snacks.picker.search_history() end, { desc = 'Search history' })
map('n', '<Leader>:', function() Snacks.picker.command_history() end, { desc = 'Command history' })
map('n', '<Leader>h', function() Snacks.picker.help() end, { desc = 'Help tags' })
map('n', '<Leader>k', function() Snacks.picker.keymaps() end, { desc = 'Keymaps' })
