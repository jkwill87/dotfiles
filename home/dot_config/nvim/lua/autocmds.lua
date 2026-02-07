local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Trim trailing whitespace on save (replaces tidy.nvim)
autocmd('BufWritePre', {
  group = augroup('TrimWhitespace', {}),
  callback = function(args)
    if not vim.bo[args.buf].modifiable then return end
    local view = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Terminal: disable line numbers and enter insert mode
autocmd('TermOpen', {
  group = augroup('TerminalSettings', {}),
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.cmd.startinsert()
  end,
})
