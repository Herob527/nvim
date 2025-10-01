local M = {}

M.treesitter = { "nginx" }

M.lspconfig = {
	{ lsp = "nginx_language_server" },
}

M.mason = {}

M.mason.lspconfig = {
	{ name = "nginx_language_server", package_manager = "npm" },
}

M.conform = {
	{ name = "nginxfmt", package_manager = "pip" },
}

return M
