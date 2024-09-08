local M = {}

M.init = function()
	local luasnip = require("luasnip")
	local cmp = require("cmp")

	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	local lspkind = require("lspkind")
	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	cmp.setup.cmdline(":%s/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})
	-- `:` cmdline setup.
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{
				name = "cmdline",
				option = {
					ignore_cmds = { "Man", "!" },
				},
			},
		}),
	})
	cmp.setup({
		performance = {
			max_view_entries = 20,
		},
		formatting = {
			format = lspkind.cmp_format({
				mode = "text_symbol", -- show only symbol annotations
				maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
				ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
				-- The function below will be called before any actual modifications from lspkind
				-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
				before = function(entry, vim_item)
					return vim_item
				end,
				menu = {
					nvim_lsp = "[LSP]",
					nvim_lsp_signature_help = "[LSP-Sign]",
					spell = "[Spell]",
					luasnip = "[Luasnip]",
					path = "[Path]",
					buffer = "[Buffer]",
					["cmp-tw2css"] = "[TW2CSS]",
					codeium = "[Codeium]",
				},
			}),
		},

		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		sources = cmp.config.sources({
			{ name = "luasnip" },
			{ name = "cmp-tw2css" },
			{ name = "hrsh7th/cmp-cmdline" },
			{
				name = "nvim_lsp",

				entry_filter = function(entry)
					return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
				end,
			},
			{ name = "nvim_lsp_signature_help" },
			{
				name = "nvim_lua",
			},
			{
				name = "spell",
				option = {
					keep_all_entries = false,
					enable_in_context = function()
						return true
					end,
				},
			},
			{ name = "path" },
			{ name = "buffer" },
			{ name = "codeium" },
		}),

		mapping = cmp.mapping.preset.insert({
			["<C-f>"] = cmp.mapping.scroll_docs(-4),
			["<C-b>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<Enter>"] = cmp.mapping.confirm({ select = true }),
			["<C-t>"] = cmp.mapping(function(fallback)
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif cmp.visible() then
					cmp.select_next_item()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<C-q>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
	})
end

M.config = {
	"hrsh7th/nvim-cmp",
	event = { "InsertCharPre", "CmdlineEnter" },
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "onsails/lspkind.nvim" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		{ "f3fora/cmp-spell" },
		{
			"zanadoman/codeium.nvim",
			config = function()
				require("codeium").setup({ ignored_errors = { 408, 503, 504 } })
			end,
		},
		{ "jcha0713/cmp-tw2css" },
		{
			"L3MON4D3/LuaSnip",
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
	},
	config = function()
		M.init()
	end,
}
return M
