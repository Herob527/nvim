local M = {}

M.treesitter = {}

M.lspconfig = {
	{ lsp = "tailwindcss" },
}

M.mason = {}

M.mason.lspconfig = {
	"tailwindcss",
}

M.mason.null_ls = {
	"rustywind",
}

M.null_ls = {
	formatter = { { program = "rustywind" } },
}
return M
