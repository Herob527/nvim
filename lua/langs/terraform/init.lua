local M = {}

M.treesitter = { "terraform" }

M.lspconfig = {
	{ lsp = "terraformls" },
}

M.mason = {}

M.mason.lspconfig = {
	"terraformls",
}

M.mason.null_ls = {}

M.null_ls = {}
return M
