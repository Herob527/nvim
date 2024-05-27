local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

local mason = require("lazy.config_parts.language")

local lazyinstalls = {
	require("plugins.colorscheme.init").config,
	require("plugins.treesitter.init").config,
	require("plugins.nvim_tree.init").config,
	"nvim-lua/plenary.nvim",
	require("plugins.telescope.init").config,
	require("plugins.gitsigns.init").config,
	require("plugins.lazygit.init").config,
	require("plugins.refactoring.init").config,
	-- require("plugins.mason.dap").config,
	require("plugins.cmp.init").config,
	require("plugins.lualine.init").config,
	require("plugins.bufferline.init").config,
	require("plugins.trouble.init").config,
	require("plugins.leap.init").config,
	require("plugins.spectre.init").config,
	require("plugins.code_action_menu.init").config,
	require("plugins.nvim_comment.init").config,
	require("plugins.mini.cursorword").config,
	require("plugins.which_key.init").config,
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
		opts = {
			-- options
		},
	},
	{
		"kosayoda/nvim-lightbulb",
		event = "LspAttach",
	},
	mason,
}

local opts = {
	defaults = {
		lazy = true,
	},
}

require("lazy").setup(lazyinstalls, opts)
