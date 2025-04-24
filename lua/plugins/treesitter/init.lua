local M = {}

M.init = function()
	local langs = require("utils.langs_table").langs_iterator()

	local ensure_installed = { "c", "vim", "markdown", "markdown_inline" }

	for val in langs do
		for _, entry in pairs(val[2].treesitter or {}) do
			table.insert(ensure_installed, entry)
		end
	end

	require("nvim-treesitter.configs").setup({
		-- A list of parser names, or "all" (the four listed parsers should always be installed)
		ensure_installed = ensure_installed,
		highlight = {
			enable = true,
		},
		sync_install = true,
		ignore_install = {},
		auto_install = true,
		playground = {
			enable = true,
			disable = {},
			updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
			persist_queries = false, -- Whether the query persists across vim sessions
			keybindings = {
				toggle_query_editor = "o",
				toggle_hl_groups = "i",
				toggle_injected_languages = "t",
				toggle_anonymous_nodes = "a",
				toggle_language_display = "I",
				focus_language = "f",
				unfocus_language = "F",
				update = "R",
				goto_node = "<cr>",
				show_help = "?",
			},
		},
		require("treesitter-context").setup({
			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
			max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
			line_numbers = true,
			multiline_threshold = 20, -- Maximum number of lines to show for a single context
			trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			mode = "topline", -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			separator = nil,
			zindex = 20, -- The Z-index of the context window
			on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
		}),
		query_linter = {
			enable = true,
			use_virtual_text = true,
			lint_events = { "BufWrite", "CursorHold" },
		},
		tree_docs = { enable = true },
	})
	vim.treesitter.language.register("markdown", "mdx")
	require("nvim-ts-autotag").setup({
		opts = {
			-- Defaults
			enable_close = true, -- Auto close tags
			enable_rename = true, -- Auto rename pairs of tags
			enable_close_on_slash = false, -- Auto close on trailing </
		},
		-- Also override individual filetype configs, these take priority.
		-- Empty by default, useful if one of the "opts" global settings
		-- doesn't work well in a specific filetype
		per_filetype = {
			["html"] = {
				enable_close = false,
			},
		},
	})
end

M.config = {
	"nvim-treesitter/nvim-treesitter",
	build = function()
		vim.cmd([[:TSUpdate]])
	end,
	event = "VeryLazy",
	dependencies = {
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/playground",
		"nvim-treesitter/nvim-tree-docs",
		"nvim-treesitter/nvim-treesitter-context",
	},
	config = function()
		M.init()
	end,
}

return M
