local M = {}

M.treesitter = {
	"css",
	"scss",
}

M.lspconfig = {
	{ lsp = "cssls" },
	{ lsp = "cssmodules_ls" },
	{ lsp = "unocss", filetypes = { "astro", "javascript", "javascriptreact", "typescript", "typescriptreact" } },
	{ lsp = "stylelint_lsp" },
	{ lsp = "somesass_ls" },
}

M.mason = {}

M.mason.lspconfig = {
	{ name = "cssls", package_manager = "npm" },
	{ name = "cssmodules_ls", package_manager = "npm" },
	{ name = "somesass_ls", package_manager = "npm" },
	{ name = "unocss", package_manager = "npm" },
	{ name = "stylelint_lsp", package_manager = "npm" },
}

M.conform = {
	{ name = "prettierd", requires = { ".prettierrc", ".prettierrc.json", "prettier.config.mjs" }, package_manager = "npm" },
}

return M
