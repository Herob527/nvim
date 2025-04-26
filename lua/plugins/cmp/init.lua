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

local minuet = {
	name = "minuet",
	module = "minuet.blink",
	async = true,
	-- Should match minuet.config.request_timeout * 1000,
	-- since minuet.config.request_timeout is in seconds
	timeout_ms = 3000,
	score_offset = 50, -- Gives minuet higher priority among suggestions

	transform_items = function(_, items)
		for _, item in ipairs(items) do
			item.labelDetails = {
				description = "[AI]",
			}
		end
		return items
	end,
}

M.config = {
	"saghen/blink.cmp",
	version = "1.*",
	opts = function()
		local is_ai_service_running = require("utils.ai-utils").is_operational()
		local providers = { ripgrep = ripgrep }
		local sources = { "lsp", "path", "snippets", "buffer", "ripgrep" }
		if is_ai_service_running then
			providers = vim.tbl_extend("keep", providers, { minuet = minuet })
			sources = vim.tbl_extend("keep", sources, { "minuet" })
		end
		return {
			keymap = { preset = "enter" },

			appearance = {

				highlight_ns = vim.api.nvim_create_namespace("blink_cmp"),
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- Will be removed in a future release
				use_nvim_cmp_as_default = false,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
				kind_icons = {
					Text = "󰉿",
					Method = "󰊕",
					Function = "󰊕",
					Constructor = "󰒓",

					Field = "󰜢",
					Variable = "󰆦",
					Property = "󰖷",

					Class = "󱡠",
					Interface = "󱡠",
					Struct = "󱡠",
					Module = "󰅩",

					Unit = "󰪚",
					Value = "󰦨",
					Enum = "󰦨",
					EnumMember = "󰦨",

					Keyword = "󰻾",
					Constant = "󰏿",

					Snippet = "󱄽",
					Color = "󰏘",
					File = "󰈔",
					Reference = "󰬲",
					Folder = "󰉋",
					Event = "󱐋",
					Operator = "󰪚",
					TypeParameter = "󰬛",
				},
			},
			signature = { enabled = true },
			completion = {
				list = { selection = { preselect = true, auto_insert = false } },
				-- ghost_text = {
				-- 	enabled = true,
				-- },
				menu = {
					border = "double",
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
				keymap = {
					preset = "default",
					["<Up>"] = { "select_prev", "fallback" },
					["<Down>"] = { "select_next", "fallback" },
				},
				completion = {
					menu = {
						auto_show = function(ctx)
							return vim.fn.getcmdtype() == ":"
						end,
					},
				},
			},
			snippets = { preset = "luasnip" },
			sources = {
				default = sources,
				providers = providers,
			},

			fuzzy = { implementation = "prefer_rust" },
		}
	end,
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
		{
			"milanglacier/minuet-ai.nvim",

			enabled = function()
				return require("utils.ai-utils").is_operational()
			end,
			config = function()
				require("minuet").setup({
					provider = "openai_fim_compatible",
					n_completions = 1, -- recommend for local model for resource saving
					-- I recommend beginning with a small context window size and incrementally
					-- expanding it, depending on your local computing power. A context window
					-- of 512, serves as an good starting point to estimate your computing
					-- power. Once you have a reliable estimate of your local computing power,
					-- you should adjust the context window to a larger value.
					context_window = 512,
					provider_options = {
						openai_fim_compatible = {
							-- For Windows users, TERM may not be present in environment variables.
							-- Consider using APPDATA instead.
							api_key = "TERM",
							name = "Llama.cpp",
							end_point = require("utils.ai-utils").OPEN_AI_ENDPOINT .. "/completions",
							-- The model is set by the llama-cpp server and cannot be altered
							-- post-launch.
							model = "qwen2.5-7b-instruct-1m",
							optional = {
								max_tokens = 256,
								top_p = 0.9,
							},
							-- Llama.cpp does not support the `suffix` option in FIM completion.
							-- Therefore, we must disable it and manually populate the special
							-- tokens required for FIM completion.
							-- template = {
							-- 	prompt = function(context_before_cursor, context_after_cursor, _)
							-- 		return "<|fim_prefix|>"
							-- 			.. context_before_cursor
							-- 			.. "<|fim_suffix|>"
							-- 			.. context_after_cursor
							-- 			.. "<|fim_middle|>"
							-- 	end,
							-- 	suffix = false,
							-- },
						},
					},
				})
			end,
		},
	},
}
return M
