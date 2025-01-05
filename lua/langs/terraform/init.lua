local M = {}

M.treesitter = { "terraform" }

M.lspconfig = {
	{ lsp = "terraformls" },
}

M.mason = {}

M.mason.lspconfig = {
	"terraformls",
}

return M
