local M = {}

M.treesitter = {
	"graphql",
}

M.lspconfig = {
	{ lsp = "graphql" },
}

M.mason = {}

M.mason.lspconfig = {
	{ name = "graphql", package_manager = "npm" },
}

M.conform = {
	{ name = "prettierd", requires = { ".prettierrc", ".prettierrc.json", "prettier.config.mjs" }, package_manager = "npm" },
}

return M
