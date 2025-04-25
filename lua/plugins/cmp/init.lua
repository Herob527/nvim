local M = {}

local ripgrep = {
	module = "blink-ripgrep",
	name = "Ripgrep",
	-- the options below are optional, some default values are shown
	---@module "blink-ripgrep"
	---@type blink-ripgrep.Options
	opts = {
		prefix_min_len = 3,
		context_size = 5,
		max_filesize = "1M",
		project_root_marker = ".git",
		project_root_fallback = true,
		search_casing = "--ignore-case",
		additional_rg_options = {},
		fallback_to_regex_highlighting = true,
		ignore_paths = {},
		additional_paths = {},
		toggles = {
			on_off = nil,
		},
		future_features = {
			issue185_workaround = true,
			backend = {
				use = "ripgrep",
			},
		},
		debug = false,
	},
	transform_items = function(_, items)
		for _, item in ipairs(items) do
			item.labelDetails = {
				description = "[RG]",
			}
		end
		return items
	end,
}

M.config = {
	"saghen/blink.cmp",
	lazy = false,
	version = "1.*",
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = { preset = "enter" },

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},
		signature = { enabled = true },
		-- (Default) Only show the documentation popup when manually triggered
		completion = {
			list = { selection = { preselect = true, auto_insert = false } },
			ghost_text = {
				enabled = true,
			},
			menu = {
				draw = {
					components = {
						kind_icon = {
							text = function(ctx)
								local lspkind = require("lspkind")
								local icon = ctx.kind_icon
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
									if dev_icon then
										icon = dev_icon
									end
								else
									icon = lspkind.symbolic(ctx.kind, {
										mode = "symbol",
									})
								end

								return icon .. ctx.icon_gap
							end,

							-- Optionally, use the highlight groups from nvim-web-devicons
							-- You can also add the same function for `kind.highlight` if you want to
							-- keep the highlight groups in sync with the icons.
							highlight = function(ctx)
								local hl = ctx.kind_hl
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
									if dev_icon then
										hl = dev_hl
									end
								end
								return hl
							end,
						},
					},
				},
			},
			documentation = { auto_show = true },
		},
		cmdline = {
			-- recommended, as the default keymap will only show and select the next item
			keymap = {
				preset = "default",
				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
			},
			completion = {
				menu = {
					auto_show = function(ctx)
						return vim.fn.getcmdtype() == ":"
						-- enable for inputs as well, with:
						-- or vim.fn.getcmdtype() == '@'
					end,
				},
			},
		},
		snippets = { preset = "luasnip" },
		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "ripgrep" },
			providers = { ripgrep = ripgrep },
		},

		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust" },
	},
	opts_extend = { "sources.default" },
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			config = function()
				-- Snippets
				require("snippets.javascript.init")
				require("snippets.css.init")
				require("snippets.astro.init")
				require("snippets.vue.init")

				vim.keymap.set({ "n", "i" }, "<C-Esc>", function()
					require("luasnip").unlink_current()
				end, { desc = "Unlink current snippet" })
			end,
		},
		"onsails/lspkind.nvim",
		"nvim-tree/nvim-web-devicons",
		"mikavilpas/blink-ripgrep.nvim",
	},
}
return M
