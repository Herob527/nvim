local M = {}

M.treesitter = { "prisma" }

M.lspconfig = {
	{ lsp = "prismals" },
}

M.mason = {}

M.mason.lspconfig = {
	"prismals",
}

M.mason.null_ls = {}

M.null_ls = {}
return M
