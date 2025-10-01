local M = {}

M.treesitter = { "terraform" }

M.lspconfig = {
	{ lsp = "terraformls" },
}

M.mason = {}

M.mason.lspconfig = {
	{ name = "terraformls", package_manager = "github" },
}

return M
