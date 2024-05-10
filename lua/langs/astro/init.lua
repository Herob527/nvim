local M = {}

M.treesitter = {
	"astro",
}

M.lspconfig = {
	{ lsp = "astro" },
	{ lsp = "eslint" },
}

M.mason = {}

M.mason.lspconfig = {
	"astro",
	"eslint",
}

M.mason.null_ls = {}

M.null_ls = {
	formatting = {
		{ program = "prettierd", with = { filetypes = { "astro" } } },
		{ program = "rustywind", with = { filetypes = { "astro" } } },
	},
}
return M
