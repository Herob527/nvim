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

	{
		"monkoose/neocodeium",
		event = "InsertEnter",
		cmd = { "NeoCodeium" },
		config = function()
			local neocodeium = require("neocodeium")
			neocodeium.setup()
			local is_tmux = os.getenv("TERM_PROGRAM") == "tmux"
			local is_zellij = os.getenv("ZELLIJ") ~= nil
			local accept_keybind = ""
			if is_tmux then
				accept_keybind = "<A-r>"
			elseif is_zellij then
				accept_keybind = "<C-Tab>"
			else
				accept_keybind = "<C-`>"
			end
			vim.keymap.set("i", accept_keybind, neocodeium.accept)
			vim.keymap.set("i", "<A-e>", function()
				neocodeium.cycle_or_complete()
			end)
		end,
	},
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
		"nvim-flutter/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = true,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			explorer = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			picker = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = false },
			statuscolumn = { enabled = true },
			words = { enabled = true },
		},
	},
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		config = true,
		keys = {
			{ "<leader>a", nil, desc = "AI/Claude Code" },
			{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
			{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
			{ "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
			{ "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
			{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
			{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
			{
				"<leader>as",
				"<cmd>ClaudeCodeTreeAdd<cr>",
				desc = "Add file",
				ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
			},
			-- Diff management
			{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
			{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		},
	},
	{
		"seblyng/roslyn.nvim",
		event = "VeryLazy",
		---@module 'roslyn.config'
		---@type RoslynNvimConfig
		config = function()
			vim.lsp.config("roslyn", {
				on_attach = function()
					print("This will run when the server attaches!")
				end,
				settings = {
					["csharp|inlay_hints"] = {
						csharp_enable_inlay_hints_for_implicit_object_creation = true,
						csharp_enable_inlay_hints_for_implicit_variable_types = true,
					},
					["csharp|code_lens"] = {
						dotnet_enable_references_code_lens = true,
					},
				},
			})
		end,
		opts = {
			-- your configuration comes here; leave empty for default settings
		},
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
