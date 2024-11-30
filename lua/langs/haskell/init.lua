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

M.mason.null_ls = {}

M.null_ls = {}
return M
