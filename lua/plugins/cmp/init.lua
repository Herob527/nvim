local M = {}

M.config = {
	"saghen/blink.cmp",
	version = "v0.*",
	-- !Important! Make sure you're using the latest release of LuaSnip
	-- `main` does not work at the moment
	dependencies = {
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		config = function()
			require("snippets.javascript.init")
			require("snippets.css.init")
			require("snippets.astro.init")
			require("snippets.vue.init")
		end,
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts_extend = { "sources.default" },
	event = { "InsertCharPre", "CmdlineEnter" },
	config = function()
		require("blink.cmp").setup({

			keymap = {
				preset = "enter",
			},

			appearance = {
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			signature = { enabled = true },
			completion = {
				list = {
					max_items = 50,
					selection = function(ctx)
						return ctx.mode == "cmdline" and "auto_insert" or "preselect"
					end,
				},
				menu = {
					border = "single",
					draw = {

						padding = 1,
						columns = {
							{ "label", "label_description", gap = 2 },
							{ "kind_icon", "kind", gap = 1 },
						},
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 100,
					window = {
						border = "single",
					},
				},
				ghost_text = { enabled = true },
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
		})
		-- M.init()
	end,
}
return M
