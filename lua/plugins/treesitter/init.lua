local M = {}

M.init = function()
	local langs = require("utils.langs_table").langs_iterator()

	local parsers = { "c", "vim", "markdown", "markdown_inline" }

	for val in langs do
		for _, entry in pairs(val[2].treesitter or {}) do
			table.insert(parsers, entry)
		end
	end

	require("nvim-treesitter").install(parsers)

	vim.api.nvim_create_autocmd("FileType", {
		callback = function()
			pcall(vim.treesitter.start)
		end,
	})

	vim.treesitter.language.register("markdown", "mdx")

	require("treesitter-context").setup({
		enable = true,
		max_lines = 5,
		line_numbers = true,
		multiline_threshold = 20,
		trim_scope = "outer",
		mode = "topline",
		separator = nil,
		zindex = 20,
		on_attach = nil,
	})

	require("nvim-ts-autotag").setup({
		opts = {
			enable_close = true,
			enable_rename = true,
			enable_close_on_slash = false,
		},
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
	branch = "main",
	event = "VeryLazy",
	dependencies = {
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-context",
	},
	config = function()
		M.init()
	end,
}

return M
