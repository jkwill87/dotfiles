require('claude-keyfinder').setup {
  -- Keep Claude Code telemetry off for these background lookups
  args = {
    '--settings',
    vim.json.encode {
      env = {
        CLAUDE_CODE_ENABLE_TELEMETRY = '0',
        CLAUDE_CODE_ENHANCED_TELEMETRY_BETA = '0',
        OTEL_LOGS_EXPORTER = 'none',
        OTEL_METRICS_EXPORTER = 'none',
        OTEL_TRACES_EXPORTER = 'none',
      },
    },
  },
}

vim.keymap.set('n', '<Leader>?', function() require('claude-keyfinder').ask() end, { desc = 'Ask Claude for a key or command' })
