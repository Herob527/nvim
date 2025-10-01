local M = {}

M.treesitter = { "vue" }

local vue_plugin_path = vim.fn.stdpath("data") .. "/npm_packages" .. "/node_modules/@vue/typescript-plugin"

M.lspconfig = {
	{
		lsp = "vtsls",
		settings = {
			vtsls = {
				tsserver = {
					globalPlugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_plugin_path,
							languages = { "typescript", "javascript", "vue" },
							enableForWorkspaceTypeScriptVersions = true,
							configNamespace = "typescript",
						},
					},
				},
			},
		},
		filetypes = {
			"vue",
		},
	},
	{ lsp = "eslint" },
}

M.mason = {}

M.mason.lspconfig = {
	{ name = "eslint", package_manager = "npm" },
	{ name = "vtsls", package_manager = "npm" },
}

M.conform = {
	{ name = "prettierd", requires = { ".prettierrc", ".prettierrc.json", "prettier.config.mjs" }, package_manager = "npm" },
}

return M
