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
	{
		"yioneko/nvim-vtsls",
		event = "LspAttach",
		config = function()
			require("lspconfig.configs").vtsls = require("vtsls").lspconfig
		end,
		dependencies = { "neovim/nvim-lspconfig" },
	},
	{
		"dmmulroy/tsc.nvim",
		config = function()
			require("tsc").setup()
		end,
		event = "LspAttach",
	},
	{
		"mrcjkb/haskell-tools.nvim",
		event = "LspAttach",
	},
	{
		"MysticalDevil/inlay-hints.nvim",
		event = "LspAttach",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("inlay-hints").setup()
		end,
	},
	{
		"LunarVim/bigfile.nvim",
		event = "VeryLazy",
	},
	{
		"VidocqH/lsp-lens.nvim",
		event = "BufRead",
		opts = {
			include_declaration = true, -- Reference include declaration
		},
		sections = {
			definition = function(count)
				return "Definitions: " .. count
			end,
			references = function(count)
				return "References: " .. count
			end,
			implements = function(count)
				return "Implements: " .. count
			end,
			git_authors = function(latest_author, count)
				return " " .. latest_author .. (count - 1 == 0 and "" or (" + " .. count - 1))
			end,
		},
		keys = {
			{
				-- LspLensToggle
				"<leader>uL",
				"<cmd>LspLensToggle<CR>",
				desc = "LSP Len Toggle",
			},
		},
	},
	mason,
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
