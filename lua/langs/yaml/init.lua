local M = {}

M.treesitter = { "yaml" }

M.lspconfig = {
	{
		lsp = "yamlls",
		settings = {
			yaml = {
				schemaStore = {
					-- You must disable built-in schemaStore support if you want to use
					-- this plugin and its advanced options like `ignore`.
					enable = false,
					-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
					url = "",
				},
				schemas = require("schemastore").yaml.schemas(),
			},
		},
	},
	{
		lsp = "gitlab_ci_ls",
	},
}

M.mason = {}

M.mason.lspconfig = {
	"yamlls",
	"gitlab_ci_ls",
}

M.conform = {
	-- "yamlfmt",
}

M.linter = {
	"yamllint",
}

return M
