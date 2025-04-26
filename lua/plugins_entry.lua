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

	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		enabled = function()
			return require("utils.ai-utils").is_operational()
		end,
		opts = {
			provider = "openai",
			openai = {
				endpoint = require("utils.ai-utils").OPEN_AI_ENDPOINT,
				model = require("utils.ai-utils").TESTED_MODEL_ID,
				temperature = 0.5,
				max_tokens = 1024,
			},
			windows = {
				---@type "right" | "left" | "top" | "bottom"
				position = "right", -- the position of the sidebar
				wrap = true, -- similar to vim.o.wrap
				width = 30, -- default % based on available width
				sidebar_header = {
					enabled = true, -- true, false to enable/disable the header
					align = "center", -- left, center, right for title
					rounded = true,
				},
				input = {
					prefix = "> ",
					height = 8, -- Height of the input window in vertical layout
				},
				edit = {
					border = "single",
					start_insert = true, -- Start insert mode when opening the edit window
				},
				ask = {
					floating = false, -- Open the 'AvanteAsk' prompt in a floating window
					start_insert = true, -- Start insert mode when opening the ask window
					border = "single",
					---@type "ours" | "theirs"
					focus_on_apply = "ours", -- which diff to focus after applying
				},
			},
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
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
