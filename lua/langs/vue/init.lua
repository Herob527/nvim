local M = {}

M.treesitter = { "vue" }

M.lspconfig = {
	{
		lsp = "tsserver",
		init_options = {
			plugins = {
				{
					name = "@vue/typescript-plugin",
					location =   vim.fn.stdpath("data") .. "/lazy".. "/packages" .. "/node_modules/@vue/typescript-plugin",
					languages = { "javascript", "typescript", "vue" },
				},
			},
		},
		filetypes = {
			"javascript",
			"typescript",
			"vue",
		},
	},
	{ lsp = "volar" },
	{ lsp = "eslint" },
}

M.mason = {}

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
