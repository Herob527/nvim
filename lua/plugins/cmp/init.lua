local M = {}

M.config = {
	"saghen/blink.cmp",
	version = "v0.*",
	-- !Important! Make sure you're using the latest release of LuaSnip
	-- `main` does not work at the moment
	dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "enter",
		},
		appearance = {
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},
		completion = {
			list = {
				selection = "manual",
			},
		},
		snippets = {
			expand = function(snippet)
				require("luasnip").lsp_expand(snippet)
			end,
			active = function(filter)
				if filter and filter.direction then
					return require("luasnip").jumpable(filter.direction)
				end
				return require("luasnip").in_snippet()
			end,
			jump = function(direction)
				require("luasnip").jump(direction)
			end,
		},
		sources = {
			default = { "lsp", "path", "luasnip", "buffer", "cmdline" },
		},
	},
	opts_extend = { "sources.default" },
	event = { "InsertCharPre", "CmdlineEnter" },
	config = function()
		require("blink.cmp").setup()
		-- M.init()
	end,
}
return M
