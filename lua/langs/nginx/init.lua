local M = {}

M.treesitter = { "nginx" }

M.lspconfig = {
	{ lsp = "nginx_language_server" },
}

M.mason = {}

M.mason.lspconfig = {
	"nginx_language_server",
}

M.conform = {
	"nginxfmt",
}

return M
