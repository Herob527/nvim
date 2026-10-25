local M = {}

M.lspconfig = {
	{ lsp = "vale_ls" },
	{ lsp = "typos_lsp" },
}

M.mason = {}

M.mason.lspconfig = {
	{ name = "vale_ls", package_manager = "github" },
	{ name = "typos_lsp", package_manager = "github" },
}

return M
