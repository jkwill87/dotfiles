require('nvim-treesitter').setup {}

-- Parsers to keep installed. `install` is a no-op for parsers already present
-- and runs asynchronously, so it is safe to call on every startup.
-- quokka:sort
local languages = {
  'bash',
  'css',
  'diff',
  'embedded_template',
  'fish',
  'git_rebase',
  'gitcommit',
  'html',
  'javascript',
  'json',
  'python',
  'regex',
  'ruby',
  'rust',
  'toml',
  'tsx',
  'typescript',
  'yaml',
}
require('nvim-treesitter').install(languages)

-- Enable treesitter highlighting for all filetypes with an available parser.
-- Indentation is left to Nvim's built-in indent scripts, which cover every
-- filetype here; nvim-treesitter still considers its own indent experimental.
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('TreesitterHighlight', {}),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if lang then
      pcall(vim.treesitter.start, args.buf, lang)
    end
  end,
})

-- Endwise: auto-close blocks in Ruby, Lua, etc.
require('nvim-treesitter-endwise').init()
