-- Set Options
-- :help vim.opt
-- :help option-list

-- ..
vim.opt.termguicolors = true

-- enable line numbers
vim.opt.number = true
-- use relative numbers
-- vim.opt.relativenumber = true

-- how many columns a tab uses (rendering)
vim.opt.tabstop = 2
-- how many columns to index in operations (ie >>)
vim.opt.shiftwidth = 2
-- insert spaces instead of tabs on tab press
vim.opt.expandtab = true
-- autoindent newlines
vim.opt.smartindent = true

-- enable mouse mode
vim.opt.mouse = 'a'

-- disable mode since status line will have this info
vim.opt.showmode = false

-- sync OS and Neovim clipboard
-- :help 'clipboard'
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- enable break indent
vim.opt.breakindent = true

-- save undo history
vim.opt.undofile = true

-- always on sign column
vim.opt.signcolumn = 'yes'

-- decrease update time
vim.opt.updatetime = 250

-- decrease wait time for mapped sequences
vim.opt.timeoutlen = 300

-- splits should be right on vertical
--                  below on horizontal
vim.opt.splitright = true
vim.opt.splitbelow = true

-- show certain whitespace character as characters
-- :help 'list'
-- :help 'listchars'
vim.opt.list = true
vim.opt.listchars = { 
  tab = '» ', 
  trail = '·', 
  nbsp = '␣'
}

-- show match while typing
-- vim.opt.incsearch = true
-- preview substitutions while typing
vim.opt.inccommand = 'split'
-- searching is case-insensitive
vim.opt.ignorecase = true
-- case-sensitive if uppercase used
vim.opt.smartcase = true

-- highlight cursor line
vim.opt.cursorline = true

-- maintain x lines above/below cursor
vim.opt.scrolloff = 10

-- present a confirmation dialog instead of erring (ie on :q)
-- :help 'confirm'
vim.opt.confirm = true

-- remove search highlights after pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Keymaps
-- :help vim.keymap.set()

-- disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '')
vim.keymap.set('n', '<down>', '')
vim.keymap.set('n', '<up>', '')
vim.keymap.set('n', '<right>', '')

