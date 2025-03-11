local M = {}

M.treesitter = { "json" }

M.lspconfig = {
	{
		lsp = "jsonls",
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
			},
		},
	},
}

M.mason = {}

M.mason.lspconfig = {
	"jsonls",
}

M.conform = {
	{ name = "prettierd", requires = { ".prettierc" } },
}

return M
