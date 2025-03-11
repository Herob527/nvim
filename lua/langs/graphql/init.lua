local M = {}

M.treesitter = {
	"graphql",
}

M.lspconfig = {
	{ lsp = "graphql" },
}

M.mason = {}

M.mason.lspconfig = {
	"graphql",
}

M.conform = {
	{ name = "prettierd", requires = { ".prettierc" } },
}

return M
