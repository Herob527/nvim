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
	"prettierd",
}

return M
