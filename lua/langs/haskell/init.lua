local M = {}

M.treesitter = {
	"haskell",
}

M.lspconfig = {
	{ lsp = "hls" },
}

M.mason = {}

M.mason.lspconfig = {
	"hls",
}

return M
