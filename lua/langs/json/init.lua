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
	{ name = "jsonls", package_manager = "npm" },
}

M.conform = {
	{ name = "jq", package_manager = "github" },
}

return M
