local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Filetypes where trailing whitespace carries meaning
local keep_trailing_whitespace = {
  diff = true,
  gitsendemail = true,
  mail = true,
  markdown = true,
}

-- Trim trailing whitespace on save (replaces tidy.nvim)
autocmd('BufWritePre', {
  group = augroup('TrimWhitespace', {}),
  callback = function(args)
    if not vim.bo[args.buf].modifiable then return end
    if keep_trailing_whitespace[vim.bo[args.buf].filetype] then return end
    local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
    local changed = false
    for i, line in ipairs(lines) do
      local trimmed = line:gsub('%s+$', '')
      if trimmed ~= line then
        lines[i] = trimmed
        changed = true
      end
    end
    if changed then
      vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, lines)
    end
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
