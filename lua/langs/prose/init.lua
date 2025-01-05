local M = {}

M.treesitter = {}

M.lspconfig = {
	{ lsp = "prosemd_lsp" },
	{ lsp = "typos_lsp" },
}

M.mason = {}

M.mason.lspconfig = {
	"prosemd_lsp",
	"typos_lsp",
}

return M
