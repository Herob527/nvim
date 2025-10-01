local M = {}

M.lspconfig = {
	{ lsp = "prosemd_lsp" },
	{ lsp = "typos_lsp" },
}

M.mason = {}

M.mason.lspconfig = {
	{ name = "prosemd_lsp", package_manager = "npm" },
	{ name = "typos_lsp", package_manager = "github" },
}

return M
