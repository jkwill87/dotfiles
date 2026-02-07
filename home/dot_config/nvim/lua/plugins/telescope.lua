local themes = require('telescope.themes')

-- Custom wide dropdown theme (used by fd picker)
function themes.get_wide_dropdown(opts)
  local theme = themes.get_dropdown(opts)
  theme.layout_config.width = function(_, max_columns, _) return math.min(max_columns, 100) end
  theme.layout_config.height = function(_, _, max_lines) return math.min(max_lines, 20) end
  return theme
end

require('telescope').setup {
  extensions = {
    file_browser = {
      hijack_netrw = true,
      theme = 'ivy',
    },
    ['ui-select'] = {
      themes.get_cursor(),
    },
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      theme = 'dropdown',
      previewer = false,
      mappings = { i = { ['<C-d>'] = 'delete_buffer' } },
    },
    oldfiles = {
      theme = 'dropdown',
      previewer = false,
      only_cwd = true,
    },
    current_buffer_fuzzy_find = {
      theme = 'dropdown',
      previewer = false,
      width = 500,
    },
    live_grep = {
      disable_coordinates = true,
    },
    fd = {
      theme = 'wide_dropdown',
      previewer = false,
    },
  },
}

require('telescope').load_extension('ui-select')
require('telescope').load_extension('gh')

-- Keymaps
local builtin = require('telescope.builtin')
local map = vim.keymap.set
map('n', '<Leader><Leader>', builtin.fd, { desc = 'Find files' })
map('n', '<Leader>g', builtin.live_grep, { desc = 'Live grep' })
map('n', '<Leader>b', builtin.buffers, { desc = 'Buffers' })
map('n', '<Leader>c', builtin.git_commits, { desc = 'Git commits' })
map('n', '<Leader>j', builtin.jumplist, { desc = 'Jumplist' })
map('n', '<C-f>', builtin.current_buffer_fuzzy_find, { desc = 'Buffer search' })
map('n', '<Leader>e', function()
  require('telescope').extensions.file_browser.file_browser { path = '%:p:h' }
end, { desc = 'File browser' })
