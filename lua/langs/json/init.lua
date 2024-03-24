local M = {}

M.treesitter = { "json" }

M.lspconfig = {
	{
		lsp = "jsonls",
	},
}

M.mason = {}

M.mason.lspconfig = {
	"jsonls",
}

M.mason.null_ls = {
	"prettierd",
}

M.null_ls = {
	formatting = { { program = "prettierd", with = { filetypes = { "json" } } } },
}
return M
