local M = {}

M.treesitter = {
	"html",
}

M.lspconfig = {
	{ lsp = "html" },
}

M.mason = {}

M.mason.lspconfig = {
	"html",
}

M.conform = {
	require("plugins.conform.formatters").prettierd,
}

return M
