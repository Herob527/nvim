local M = {}

M.treesitter = { "vue" }

M.lspconfig = {
	{
		lsp = "ts_ls",
		init_options = {
			plugins = {
				{
					name = "@vue/typescript-plugin",
					location = vim.fn.stdpath("data") .. "/npm_packages" .. "/node_modules/@vue/typescript-plugin",
					languages = { "javascript", "typescript", "vue" },
				},
			},
		},
		filetypes = {
			"vue",
		},
	},
	{ lsp = "volar" },
	{ lsp = "eslint" },
}

M.mason = {
"typescript-language-server",
}

M.mason.lspconfig = {
	"volar",
	"eslint",
}

M.mason.null_ls = {
	"prettierd",
}

M.null_ls = {
	formatting = { { program = "prettierd", with = { filetypes = { "vue" } } } },
}
return M
