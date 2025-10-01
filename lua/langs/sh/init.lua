local M = {}

M.treesitter = {
	"bash",
}

M.lspconfig = {
	{ lsp = "bashls" },
}

M.mason = {}

M.mason.lspconfig = {
	{ name = "bashls", package_manager = "npm" },
	{ name = "fish_lsp", package_manager = "npm" },
}

M.conform = {
	{ name = "shfmt", package_manager = "github" },
}

return M
