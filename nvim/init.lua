-- Read
-- :help lua
-- :help
-- :help lua-guide

-- If experiencing errors
-- :checkhealth
-- for a diagnostic

-- :help mapleader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- use nerd fonts (set true if installed)
vim.g.have_nerd_font = true

require("theno.set")
require("theno.remap")

require("theno.lazy")

-- Autocommands
-- :help lua-guide-autocommands

-- briefly highlight selection on copy
-- :help vim.highlight.on_yank()
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight on yank",
	group = vim.api.nvim_create_augroup("highlight-on-yank", {
		clear = true,
	}),
	callback = function()
		vim.highlight.on_yank()
	end,
})
