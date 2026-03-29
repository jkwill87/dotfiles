vim.diagnostic.config {
  underline = true,
  update_in_insert = false,
  severity_sort = true,
}

-- Advertise foldingRange capability to all servers (required by nvim-ufo)
vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  },
})

vim.lsp.enable {
  'lua_ls',
  'ts_ls',
  'jsonls',
  'expert',
  'jq',
  'rust_analyzer',
  'marksman',
  'fish_lsp',
  'tombi',
  'yamlls',
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LspKeymaps', {}),
  callback = function(args)
    local bufnr = args.buf
    local function bmap(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    -- Navigation
    bmap('gd', function() Snacks.picker.lsp_definitions() end, 'Goto Definition')
    bmap('gD', function() Snacks.picker.lsp_declarations() end, 'Goto Declaration')
    bmap('gI', function() Snacks.picker.lsp_implementations() end, 'Goto Implementation')
    bmap('gr', function() Snacks.picker.lsp_references() end, 'References')
    bmap('gy', function() Snacks.picker.lsp_type_definitions() end, 'Goto T[y]pe Definition')
    bmap('gai', function() Snacks.picker.lsp_incoming_calls() end, 'C[a]lls Incoming')
    bmap('gao', function() Snacks.picker.lsp_outgoing_calls() end, 'C[a]lls Outgoing')
    bmap('K', vim.lsp.buf.hover, 'Hover documentation')

    -- Actions
    bmap('<Leader>lr', vim.lsp.buf.rename, 'Rename symbol')
    bmap('<Leader>la', vim.lsp.buf.code_action, 'Code action')
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
  end,
})
