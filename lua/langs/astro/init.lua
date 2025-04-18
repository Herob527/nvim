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
	{ name = "prettierd", requires = { ".prettierc" } },
	"rustywind",
}

M.linter = {}

return M
