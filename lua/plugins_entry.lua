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
	require("plugins.which_key.init").config,
	require("plugins.lint.init").config,
	require("plugins.conform.init").config,
	require("plugins.fidget.init").config,
	require("plugins.lightbulb.init").config,
	require("plugins.vtsls.init").config,
	require("plugins.tsc.init").config,
	require("plugins.haskell_tools.init").config,
	require("plugins.inlay_hints.init").config,
	require("plugins.bigfile.init").config,
	require("plugins.eyeliner.init").config,
	require("plugins.neocodeium.init").config,
	require("plugins.mason.mason_lspconfig"),
	{
		dir = "~/.config/nvim/lua/custom_plugins/custom_stuff",
		dev = true,
		config = function()
			require("custom_plugins.custom_stuff.init").setup()
		end,
		event = "VeryLazy",
	},
	require("plugins.flutter_tools.init").config,
	require("plugins.snacks.init").config,
	require("plugins.claudecode.init").config,
	require("plugins.remote_nvim.init").config,
	require("plugins.roslyn.init").config,
}

local opts = {
	defaults = {
		lazy = true,
	},
	ui = {
		border = "rounded",
	},
	install = {
		-- install missing plugins on startup. This doesn't increase startup time.
		missing = true,
		-- try to load one of these colorschemes when starting an installation during startup
		colorscheme = { "onenord" },
	},
}

require("lazy").setup(lazyinstalls, opts)
