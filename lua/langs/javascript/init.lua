local M = {}

M.treesitter = { "javascript", "typescript", "tsx", "jsdoc" }

M.lspconfig = {
	{ lsp = "vtsls" },
	{ lsp = "eslint" },
}

M.mason = {}

M.mason.lspconfig = {
	"vtsls",
	"eslint",
}

M.mason.null_ls = {
	"prettierd",
}

M.null_ls = {
	formatting = {
		{
			program = "prettierd",
		},
	},
	rest = {},
}
return M
