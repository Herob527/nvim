local M = {}

M.treesitter = { "javascript", "typescript", "tsx", "jsdoc" }

M.lspconfig = {
	{ lsp = "tsserver" },
}

M.mason = {}

M.mason.lspconfig = {
	"tsserver",
}

M.mason.null_ls = {
	"eslint_d",
	"prettierd",
}

M.null_ls = {
	formatter = {
		{
			program = "prettierd",
			with = { filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" } },
		},
	},
	diagnostics = { { program = "eslint_d" } },
	code_actions = { { program = "eslint_d" } },
	rest = {

	},
}
return M
