local M = {}

M.treesitter = { "json" }

M.lspconfig = {
	{
		lsp = "tombi",
		settings = {
			toml = {
				schemas = require("schemastore").json.schemas(),
			},
		},
	},
}

M.mason = {}

M.mason.lspconfig = {
	{ name = "tombi", package_manager = "npm" },
}

return M
