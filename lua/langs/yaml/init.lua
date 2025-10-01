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
	{ name = "yamlls", package_manager = "npm" },
	{ name = "gitlab_ci_ls", package_manager = "npm" },
}

M.conform = {
	-- { name = "yamlfmt", package_manager = "github" },
}

M.linter = {
	{ name = "yamllint", package_manager = "pip" },
}

return M
