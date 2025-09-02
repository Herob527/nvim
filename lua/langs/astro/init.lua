local M = {}

M.treesitter = {
	"astro",
}

M.lspconfig = {
	{ lsp = "astro" },
	{
		lsp = "eslint",
		filetypes = {
			"astro",
		},
	},
}

M.mason = {}

M.mason.lspconfig = {
	"astro",
	"eslint",
}

M.conform = {
	require("plugins.conform.formatters").prettierd,
	"rustywind",
}

M.linter = {}

return M
