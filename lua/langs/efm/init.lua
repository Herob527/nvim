local M = {}

M.treesitter = {}

M.lspconfig = {
	{ lsp = "efm" },
}

M.mason = {}

M.mason.lspconfig = {
	"efm",
}
M.mason.null_ls = {}

M.null_ls = {}

return M
