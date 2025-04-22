local M = {}

M.treesitter = {
	"c_sharp",
}

M.lspconfig = {
	{ lsp = "csharp_ls" },
}

M.mason = {}

M.mason.lspconfig = {
	"csharp_ls",
}

return M
