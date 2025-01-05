local M = {}

M.treesitter = {
	"html",
}

M.lspconfig = {
	{ lsp = "html" },
}

M.mason = {}

M.mason.lspconfig = {
	"html",
}

M.conform = {
	"prettierd",
}

return M
