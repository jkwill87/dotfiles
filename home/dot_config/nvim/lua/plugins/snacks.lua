require('snacks').setup {
  words = { enabled = true },
  statuscolumn = { enabled = true },
  notifier = { enabled = true },
  input = { enabled = true },
  scroll = { enabled = true },
  git = { enabled = true },
  picker = {
    layout = { preset = 'vertical' },
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

vim.ui.input = Snacks.input.input
vim.ui.select = Snacks.picker.select

-- Keymaps
local map = vim.keymap.set

-- Files
map('n', '<Leader><Leader>', function() Snacks.picker.files() end, { desc = 'Find files' })
map('n', '<Leader>b', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
map('n', '<C-f>', function() Snacks.picker.lines() end, { desc = 'Buffer search' })
map('n', '<Leader>e', function() Snacks.picker.explorer() end, { desc = 'File browser' })
map('n', '<Leader>r', function() Snacks.picker.recent() end, { desc = 'Recent files' })

-- Git
map('n', '<Leader>gb', function() Snacks.picker.git_branches() end, { desc = 'Git Branches' })
map('n', '<Leader>gl', function() Snacks.picker.git_log() end, { desc = 'Git Log' })
map('n', '<Leader>gL', function() Snacks.picker.git_log_line() end, { desc = 'Git Log Line' })
map('n', '<Leader>gs', function() Snacks.picker.git_status() end, { desc = 'Git Status' })
map('n', '<Leader>gS', function() Snacks.picker.git_stash() end, { desc = 'Git Stash' })
map('n', '<Leader>gd', function() Snacks.picker.git_diff() end, { desc = 'Git Diff (Hunks)' })
map('n', '<Leader>gf', function() Snacks.picker.git_log_file() end, { desc = 'Git Log File' })
map({ 'n', 'v' }, '<Leader>gB', function() Snacks.gitbrowse() end, { desc = 'Git Browse' })

-- GitHub
map('n', '<Leader>gi', function() Snacks.picker.gh_issue() end, { desc = 'GitHub Issues (open)' })
map('n', '<Leader>gI', function() Snacks.picker.gh_issue({ state = 'all' }) end, { desc = 'GitHub Issues (all)' })
map('n', '<Leader>gp', function() Snacks.picker.gh_pr() end, { desc = 'GitHub Pull Requests (open)' })
map('n', '<Leader>gP', function() Snacks.picker.gh_pr({ state = 'all' }) end, { desc = 'GitHub Pull Requests (all)' })

-- Search
map('n', '<Leader>s"', function() Snacks.picker.registers() end, { desc = 'Registers' })
map('n', '<Leader>s/', function() Snacks.picker.search_history() end, { desc = 'Search History' })
map('n', '<Leader>sb', function() Snacks.picker.lines() end, { desc = 'Buffer Lines' })
map('n', '<Leader>sc', function() Snacks.picker.command_history() end, { desc = 'Command History' })
map('n', '<Leader>sC', function() Snacks.picker.commands() end, { desc = 'Commands' })
map('n', '<Leader>sd', function() Snacks.picker.diagnostics() end, { desc = 'Diagnostics' })
map('n', '<Leader>sD', function() Snacks.picker.diagnostics_buffer() end, { desc = 'Buffer Diagnostics' })
map('n', '<Leader>sh', function() Snacks.picker.help() end, { desc = 'Help Pages' })
map('n', '<Leader>sH', function() Snacks.picker.highlights() end, { desc = 'Highlights' })
map('n', '<Leader>sj', function() Snacks.picker.jumps() end, { desc = 'Jumps' })
map('n', '<Leader>sk', function() Snacks.picker.keymaps() end, { desc = 'Keymaps' })
map('n', '<Leader>sl', function() Snacks.picker.loclist() end, { desc = 'Location List' })
map('n', '<Leader>sm', function() Snacks.picker.marks() end, { desc = 'Marks' })
map('n', '<Leader>sM', function() Snacks.picker.man() end, { desc = 'Man Pages' })
map('n', '<Leader>sq', function() Snacks.picker.qflist() end, { desc = 'Quickfix List' })
map('n', '<Leader>sR', function() Snacks.picker.resume() end, { desc = 'Resume' })
map('n', '<Leader>su', function() Snacks.picker.undo() end, { desc = 'Undo History' })
map('n', '<Leader>uC', function() Snacks.picker.colorschemes() end, { desc = 'Colorschemes' })

-- Other
map('n', '<Leader>z', function() Snacks.zen() end, { desc = 'Toggle Zen Mode' })
map('n', '<Leader>Z', function() Snacks.zen.zoom() end, { desc = 'Toggle Zoom' })
map('n', '<Leader>.', function() Snacks.scratch() end, { desc = 'Toggle Scratch Buffer' })
map('n', '<Leader>S', function() Snacks.scratch.select() end, { desc = 'Select Scratch Buffer' })
map('n', '<Leader>cR', function() Snacks.rename.rename_file() end, { desc = 'Rename File' })
map('n', '<Leader>un', function() Snacks.notifier.hide() end, { desc = 'Dismiss All Notifications' })
map({ 'n', 't' }, ']]', function() Snacks.words.jump(vim.v.count1) end, { desc = 'Next Reference' })
map({ 'n', 't' }, '[[', function() Snacks.words.jump(-vim.v.count1) end, { desc = 'Prev Reference' })
map('n', '<Leader>N', function()
  Snacks.win({
    file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
    width = 0.6,
    height = 0.6,
    wo = {
      spell = false,
      wrap = false,
      signcolumn = 'yes',
      statuscolumn = ' ',
      conceallevel = 3,
    },
  })
end, { desc = 'Neovim News' })
