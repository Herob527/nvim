local M = {}

M.treesitter = {
	"haskell",
}

M.lspconfig = {
	{ lsp = "hls" },
}

M.mason = {}

M.mason.lspconfig = {
	{ name = "hls", package_manager = "github" },
}

return M
