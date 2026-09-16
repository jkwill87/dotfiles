vim.diagnostic.config {
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

vim.lsp.enable {
  'copilot',
  'fish_lsp',
  'jsonls',
  'lua_ls',
  'marksman',
  'rust_analyzer',
  'tombi',
  'ts_ls',
  'yamlls',
}

-- Nvim's global `gr*` mappings all collide with the `gr` mapping below, which
-- would stall every press for 'timeoutlen'. Everything they do is bound
-- elsewhere in this config.
for _, lhs in ipairs { 'grn', 'gra', 'gri', 'grr', 'grt', 'grx' } do
  pcall(vim.keymap.del, { 'n', 'x' }, lhs)
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LspKeymaps', {}),
  callback = function(args)
    local bufnr = args.buf
    local function bmap(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    -- Navigation ('K' is mapped to hover by Nvim's LSP defaults)
    bmap('gd', function() Snacks.picker.lsp_definitions() end, 'Goto Definition')
    bmap('gD', function() Snacks.picker.lsp_declarations() end, 'Goto Declaration')
    bmap('gI', function() Snacks.picker.lsp_implementations() end, 'Goto Implementation')
    bmap('gr', function() Snacks.picker.lsp_references() end, 'References')
    bmap('gy', function() Snacks.picker.lsp_type_definitions() end, 'Goto T[y]pe Definition')
    bmap('gai', function() Snacks.picker.lsp_incoming_calls() end, 'C[a]lls Incoming')
    bmap('gao', function() Snacks.picker.lsp_outgoing_calls() end, 'C[a]lls Outgoing')

    -- Actions
    bmap('<Leader>lr', vim.lsp.buf.rename, 'Rename symbol')
    bmap('<Leader>la', vim.lsp.buf.code_action, 'Code action')
    bmap('<Leader>lx', vim.lsp.codelens.run, 'Run code lens')
    bmap('<Leader>ss', function() Snacks.picker.lsp_symbols() end, 'LSP Symbols')
    bmap('<Leader>sS', function() Snacks.picker.lsp_workspace_symbols() end, 'LSP Workspace Symbols')

    vim.api.nvim_buf_create_user_command(
      bufnr,
      'Format',
      function() require('conform').format { lsp_fallback = true } end,
      { desc = 'Format current buffer' }
    )

    -- Native completion
    vim.lsp.completion.enable(true, args.data.client_id, bufnr, { autotrigger = true })
    vim.lsp.inline_completion.enable(true, { bufnr = bufnr })
  end,
})

-- Accept the pending inline completion, falling back to a literal Tab
vim.keymap.set('i', '<Tab>', function()
  if not vim.lsp.inline_completion.get() then
    return '<Tab>'
  end
end, { expr = true, desc = 'Accept inline completion' })

vim.keymap.set('i', '<M-]>', function()
  vim.lsp.inline_completion.select { count = 1 }
end, { desc = 'Next inline completion' })

vim.keymap.set('i', '<M-[>', function()
  vim.lsp.inline_completion.select { count = -1 }
end, { desc = 'Previous inline completion' })
