local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)


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

vim.g.mapleader = " "
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>")


-- remove extra new lines when pasing
vim.keymap.set("n", "<leader>p", ":r!pbpaste<CR>'.kJ")
vim.keymap.set("i", "<leader>p", ":r!pbpaste<CR>'.kJ")
vim.cmd("set shell=bash")
vim.cmd("set shellcmdflag=-c")
vim.cmd("set noshelltemp")


plugins = {
        { "catppuccin/nvim", name = "catppuccin", priority = 1000 }
}

require("lazy").setup(plugins, opts)


vim.cmd.colorscheme "catppuccin"
