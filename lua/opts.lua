local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.termguicolors = true
opt.shell = "zsh"
opt.clipboard = "unnamedplus"
vim.cmd([[set completeopt=menu,menuone,noselect,preview]])
