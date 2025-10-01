local M = {}

M.treesitter = { "rust" }

M.lspconfig = {
	{ lsp = "rust_analyzer" },
}

M.mason = {}

M.mason.lspconfig = {
	{ name = "rust_analyzer", package_manager = "github" },
}

return M
