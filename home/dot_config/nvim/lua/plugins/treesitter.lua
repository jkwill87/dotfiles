require'nvim-treesitter'.setup {}

-- Enable treesitter highlighting for all filetypes with an available parser
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('TreesitterHighlight', {}),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if lang and pcall(vim.treesitter.start, args.buf, lang) then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- require("nvim-treesitter.configs").setup({
--   -- Enable syntax highlighting
--   highlight = {
--     enable = true,
--     -- Optionally disable treesitter highlighting for certain filetypes
--     -- disable = { "c", "rust" },
--   },
--   -- Enable indentation
--   indent = { enable = true },
-- })

-- Endwise: auto-close blocks in Ruby, Lua, etc.
require('nvim-treesitter-endwise').init()
