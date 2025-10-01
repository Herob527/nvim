local M = {}

M.treesitter = { "markdown" }

M.lspconfig = {
	{ lsp = "marksman" },
}

M.mason = {}

M.mason.lspconfig = {
	{ name = "marksman", package_manager = "github" },
	{ name = "mdx_analyzer", package_manager = "npm" },
}

M.conform = {
	{ name = "prettierd", requires = { ".prettierrc", ".prettierrc.json", "prettier.config.mjs" }, package_manager = "npm" },
	{ name = "markdownlint", package_manager = "npm" },
}

M.linter = {
	{ name = "markdownlint", package_manager = "npm" },
}

return M
