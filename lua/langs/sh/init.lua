local M = {}

M.treesitter = {
	"bash",
}

M.lspconfig = {
	{ lsp = "bashls" },
}

M.mason = {}

M.mason.lspconfig = {
	"bashls",
}

M.mason.null_ls = {
	"shfmt",
}

M.null_ls = {
	formatting = { { program = "shfmt" } },
	rest = {},
}
return M
