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
}

M.mason = {}

M.mason.lspconfig = {
	"cssls",
	"cssmodules_ls",
	"unocss",
	"stylelint_lsp",
}

M.conform = {
	"prettierd",
}

return M
