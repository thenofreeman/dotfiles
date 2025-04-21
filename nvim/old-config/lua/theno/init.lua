vim.g.mapleader = " " -- Set leader key to SPACE

require("theno.lazy_init")

require("theno.remap")
require("theno.set")

require('Comment').setup()
require('gitsigns').setup()
require("symbols-outline").setup()
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "zls" },
}

-- vim.lsp.config('lua_ls', {
--   settings = {
--
--   }
-- })

require("lspconfig").lua_ls.setup {}
