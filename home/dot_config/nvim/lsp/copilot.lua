-- Sign-in commands are adapted from nvim-lspconfig's lsp/copilot.lua, since the
-- device-flow handshake has no equivalent in core.
local function sign_in(bufnr, client)
  client:request('signIn', vim.empty_dict(), function(err, result)
    if err then
      vim.notify(err.message, vim.log.levels.ERROR)
      return
    end

    if result.command then
      vim.fn.setreg('+', result.userCode)
      vim.fn.setreg('*', result.userCode)
      local continue = vim.fn.confirm(
        'Copied your one-time code to clipboard.\nOpen the browser to complete the sign-in process?',
        '&Yes\n&No'
      )
      if continue == 1 then
        client:exec_cmd(result.command, { bufnr = bufnr }, function(cmd_err, cmd_result)
          if cmd_err then
            vim.notify(cmd_err.message, vim.log.levels.ERROR)
          elseif cmd_result.status == 'OK' then
            vim.notify('Signed in as ' .. cmd_result.user .. '.')
          end
        end)
      end
    end

    if result.status == 'PromptUserDeviceFlow' then
      vim.notify('Enter your one-time code ' .. result.userCode .. ' in ' .. result.verificationUri)
    elseif result.status == 'AlreadySignedIn' then
      vim.notify('Already signed in as ' .. result.user .. '.')
    end
  end)
end

local function sign_out(_, client)
  client:request('signOut', vim.empty_dict(), function(err, result)
    if err then
      vim.notify(err.message, vim.log.levels.ERROR)
    elseif result.status == 'NotSignedIn' then
      vim.notify('Not signed in.')
    end
  end)
end

return {
  cmd = { 'copilot-language-server', '--stdio' },
  root_markers = { '.git' },
  init_options = {
    editorInfo = { name = 'Neovim', version = tostring(vim.version()) },
    editorPluginInfo = { name = 'Neovim', version = tostring(vim.version()) },
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspCopilotSignIn', function()
      sign_in(bufnr, client)
    end, { desc = 'Sign in Copilot with GitHub' })
    vim.api.nvim_buf_create_user_command(bufnr, 'LspCopilotSignOut', function()
      sign_out(bufnr, client)
    end, { desc = 'Sign out Copilot with GitHub' })
  end,
}
