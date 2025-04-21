-- Keymaps
-- :help vim.keymap.set()

-- disable arrow keys in normal mode
vim.keymap.set("n", "<left>", "")
vim.keymap.set("n", "<down>", "")
vim.keymap.set("n", "<up>", "")
vim.keymap.set("n", "<right>", "")

vim.keymap.set("n", "<C-k>", vim.diagnostic.open_float, {
	desc = "Show line diagnostics",
})

-- local wk = require("which-key")
-- wk.add({})
