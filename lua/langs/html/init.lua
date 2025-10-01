local M = {}

M.treesitter = {
	"html",
}

M.lspconfig = {
	{ lsp = "html" },
}

M.mason = {}

M.mason.lspconfig = {
	{ name = "html", package_manager = "npm" },
}

M.conform = {
	{ name = "prettierd", requires = { ".prettierrc", ".prettierrc.json", "prettier.config.mjs" }, package_manager = "npm" },
}

return M
