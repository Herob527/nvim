local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.termguicolors = true
opt.shell = os.getenv("SHELL") or "fish"
opt.clipboard = "unnamedplus"
vim.cmd([[set completeopt=menu,menuone,noselect,preview]])
opt.foldmethod = "marker"
opt.foldmarker = "#region,#endregion"

if vim.g.neovide then
	vim.g.neovide_cursor_animation_length = 0
	vim.o.guifont = "Source Code Pro:h10" -- text below applies for VimScript
end
