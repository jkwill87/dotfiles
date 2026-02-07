-- Soft-wrap long lines at word boundaries
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.list = false

-- Navigate by visual lines instead of real lines
local opts = { buffer = true, nowait = true }
vim.keymap.set({ 'n', 'v' }, 'j', 'gj', opts)
vim.keymap.set({ 'n', 'v' }, 'k', 'gk', opts)
vim.keymap.set({ 'n', 'v' }, '0', 'g0', opts)
vim.keymap.set({ 'n', 'v' }, '^', 'g^', opts)
vim.keymap.set({ 'n', 'v' }, '$', 'g$', opts)
