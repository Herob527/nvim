local M = {}

M.treesitter = {
	"dockerfile",
}

M.lspconfig = {
	{ lsp = "dockerls" },
}

M.mason = {}

M.mason.lspconfig = {
	{ name = "dockerls", package_manager = "npm" },
}

M.linter = {
	{ name = "hadolint", package_manager = "github" },
}

return M
