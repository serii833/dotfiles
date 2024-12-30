vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_netrw = 1


vim.opt.clipboard = "unnamedplus"

vim.g.mapleader = " "
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>")

-- do not overwrite clipboard on paste over selection
vim.keymap.set('x', 'p', 'P')
vim.keymap.set('n', '<C-v>', 'p')
vim.keymap.set('i', '<C-v>', '<Esc>pA')


vim.keymap.set("n", "<leader>p", ":r!pbpaste<CR>'.kJ")
-- vim.keymap.set("i", "<leader>p", ":r!pbpaste<CR>'.kJ")

vim.keymap.set("n", "<C-h>",  "<C-w>h")
vim.keymap.set("n", "<C-l>",  "<C-w>l")
vim.keymap.set("n", "<C-j>",  "<C-w>j")
vim.keymap.set("n", "<C-k>",  "<C-w>k")

vim.cmd("set shell=bash")
vim.cmd("set shellcmdflag=-c")
vim.cmd("set noshelltemp")
vim.cmd("let  $TMP='/tmp'")

