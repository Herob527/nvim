local M = {}

M.init = function()
	local langs = require("utils.langs_table")

	local ensure_installed = { "c", "vim", "markdown", "markdown_inline" }

	for _, val in pairs(langs) do
		for _, entry in pairs(val.treesitter) do
			table.insert(ensure_installed, entry)
		end
	end
	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

	vim.cmd([[
augroup filetypedetect
  autocmd! BufRead,BufNewFile,BufEnter *.groq setfiletype groq
augroup END
]])
	parser_config.groq = {
		install_info = {
			url = "~/Desktop/Projects/tree-sitter-groq", -- local path or git repo
			files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
			-- optional entries:
			branch = "main", -- default branch in case of git repo if different from master
			generate_requires_npm = false, -- if stand-alone parser without npm dependencies
			requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
		},
		filetype = "groq", -- if filetype does not match the parser name
	}
	vim.treesitter.language.register("groq", "groq") -- the someft filetype will use the python parser and queries.
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
		query_linter = {
			enable = true,
			use_virtual_text = true,
			lint_events = { "BufWrite", "CursorHold" },
		},
		tree_docs = { enable = true },
	})
	vim.treesitter.language.register("markdown", "mdx")
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
	},
	config = function()
		M.init()
	end,
}

return M
