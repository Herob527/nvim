local M = {}

M.treesitter = {
	"astro",
}

M.lspconfig = {
	{ lsp = "astro" },
	{
		lsp = "eslint",
	},
	{
		lsp = "oxlint",
	},
}

M.mason = {}

M.mason.lspconfig = {
	{ name = "astro", package_manager = "npm" },
	{ name = "eslint", package_manager = "npm" },
}

M.conform = {
	{
		name = "prettierd",
		requires = { ".prettierrc", ".prettierrc.json", "prettier.config.mjs" },
		package_manager = "npm",
	},
	{ name = "rustywind", package_manager = "npm" },
}

M.linter = {}

return M
