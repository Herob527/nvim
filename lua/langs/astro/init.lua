local M = {}

M.treesitter = {
	"astro",
}

M.lspconfig = {
	{ lsp = "astro" },
}

M.mason = {}

M.mason.lspconfig = {
	"astro",
	"eslint",
}

M.conform = {
	"prettierd",
	"rustywind",
}

M.linter = {
	"eslint_d",
}

return M
