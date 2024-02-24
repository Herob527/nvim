local M = {}

M.treesitter = { "rust" }

M.lspconfig = {
	{ lsp = "rust_analyzer" },
}

M.mason = {}

M.mason.lspconfig = {
	"rust_analyzer",
}

M.mason.null_ls = {}

M.null_ls = {}
return M
