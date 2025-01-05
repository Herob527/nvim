local M = {}

M.treesitter = {
	"css",
	"scss",
}

M.lspconfig = {
	{ lsp = "cssls" },
	{ lsp = "cssmodules_ls" },
	{ lsp = "unocss", filetypes = { "astro", "javascript", "javascriptreact", "typescript", "typescriptreact" } },
}

M.mason = {}

M.mason.lspconfig = {
	"cssls",
	"cssmodules_ls",
	"unocss",
}

M.conform = {
	"prettierd",
}

M.linter = {
	"stylelint",
}

return M
