local M = {}

M.treesitter = {
	"bash",
}

M.lspconfig = {
	{ lsp = "bashls" },
}

M.mason = {}

M.mason.lspconfig = {
	"bashls",
}

M.conform = {
	"shfmt",
}

return M
