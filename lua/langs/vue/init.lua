local M = {}

M.treesitter = { "vue" }

M.lspconfig = {
	{
		lsp = "vtsls",
	},
	{ lsp = "eslint" },
}

M.mason = {}

M.mason.lspconfig = {
	{ name = "eslint", package_manager = "npm" },
	{ name = "vtsls", package_manager = "npm" },
}

M.conform = {
	{
		name = "prettierd",
		requires = { ".prettierrc", ".prettierrc.json", "prettier.config.mjs" },
		package_manager = "npm",
	},
}

return M
