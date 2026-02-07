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

vim.lsp.enable { 'lua_ls', 'ts_ls', 'jsonls' }

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LspKeymaps', {}),
  callback = function(args)
    local bufnr = args.buf
    local function bmap(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    -- Navigation
    bmap('gd', vim.lsp.buf.definition, 'Go to definition')
    bmap('gD', vim.lsp.buf.declaration, 'Go to declaration')
    bmap('gI', vim.lsp.buf.implementation, 'Go to implementation')
    bmap('gr', function() Snacks.picker.lsp_references() end, 'References')
    bmap('K', vim.lsp.buf.hover, 'Hover documentation')

    -- Actions
    bmap('<Leader>lr', vim.lsp.buf.rename, 'Rename symbol')
    bmap('<Leader>la', vim.lsp.buf.code_action, 'Code action')
    bmap('<Leader>ls', function() Snacks.picker.lsp_symbols() end, 'Document symbols')
    bmap('<Leader>lw', function() Snacks.picker.lsp_workspace_symbols() end, 'Workspace symbols')

    vim.api.nvim_buf_create_user_command(
      bufnr,
      'Format',
      function() vim.lsp.buf.format() end,
      { desc = 'Format current buffer with LSP' }
    )

    -- Native completion
    vim.lsp.completion.enable(true, args.data.client_id, bufnr, { autotrigger = true })
  end,
})
