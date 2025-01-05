local M = {}

M.treesitter = {
	"dockerfile",
}

M.lspconfig = {
	{ lsp = "dockerls" },
}

M.mason = {}

M.mason.lspconfig = {
	"dockerls",
}

M.linter = {
	"hadolint",
}

return M
