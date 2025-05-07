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
	"cssls",
	"cssmodules_ls",
	"somesass_ls",
	"unocss",
	"stylelint_lsp",
}

M.conform = {
	{ name = "prettierd", requires = { ".prettierc" } },
}

return M
