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
	require("plugins.mini.cursorword").config,
	require("plugins.which_key.init").config,
	require("plugins.lint.init").config,
	require("plugins.conform.init").config,
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
		config = function()
			require("nvim-lightbulb").setup({
				autocmd = { enabled = true },
			})
		end,
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
		"jinh0/eyeliner.nvim",
		event = "VeryLazy",
		config = function()
			require("eyeliner").setup({
				-- show highlights only after keypress
				highlight_on_key = true,

				-- dim all other characters if set to true (recommended!)
				dim = true,

				max_length = 9999,

				-- filetypes for which eyeliner should be disabled;
				-- e.g., to disable on help files:
				-- disabled_filetypes = {"help"}
				disable_buftypes = { "nofile", "NvimTree" },

				-- add eyeliner to f/F/t/T keymaps;
				-- see section on advanced configuration for more information
				default_keymaps = true,
			})
		end,
	},
	-- {
	-- 	"monkoose/neocodeium",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		local neocodeium = require("neocodeium")
	-- 		neocodeium.setup()
	-- 		vim.keymap.set("i", "<C-Tab>", neocodeium.accept)
	-- 		vim.keymap.set("i", "<A-e>", function()
	-- 			neocodeium.cycle_or_complete()
	-- 		end)
	-- 	end,
	-- },
	require("lazy.config_parts.mason_lspconfig"),
	{
		dir = "~/.config/nvim/lua/custom_plugins/custom_stuff",
		dev = true,
		config = function()
			require("custom_plugins.custom_stuff.init").setup()
		end,
		event = "VeryLazy",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "BufReadPost",
		opts = function(_, opts)
			-- Other blankline configuration here
			return require("indent-rainbowline").make_opts(opts, {
				color_transparency = 0.05,
			})
		end,
		dependencies = {
			"TheGLander/indent-rainbowline.nvim",
		},
	},
	{
		"olimorris/codecompanion.nvim",
		opts = {},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		event = "VeryLazy",
		config = function()
			local ai_utils = require("utils.ai-utils")
			require("codecompanion").setup({
				strategies = {
					chat = {
						-- Explicitly set the adapter to "ollama" for the chat strategy.
						-- This tells the 'chat' strategy to use the 'ollama' adapter defined above.
						adapter = "ollama",
						-- The 'provider' is also set to "ollama" for consistency.
						provider = "ollama",

						-- Simple system prompt as mcphub is excluded for this test.
						system_prompt = 'You are an AI programming assistant named "CodeCompanion". You are currently plugged into the Neovim text editor.',
					},
				},
				adapters = {
					ollama = function()
						return require("codecompanion.adapters").extend("ollama", {
							model = ai_utils.TESTED_MODEL_ID,
							env = {
								url = ai_utils.OPEN_AI_ENDPOINT,
								api_key = "TERM",
							},
							parameters = {
								sync = true,
							},
						})
					end,
				},
			})
		end,
	},
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
