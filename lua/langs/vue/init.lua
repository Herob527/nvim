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
}

M.mason = {
	"typescript-language-server",
}

M.mason.lspconfig = {
	"volar",
}

M.linter = { "eslint_d" }

M.conform = { "eslint_d", "prettierd" }

return M
