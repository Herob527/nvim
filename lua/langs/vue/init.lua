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

M.mason = {
	"vtsls",
}

M.mason.lspconfig = {
	"eslint",
}

M.conform = {
	{ name = "prettierd", requires = { ".prettierrc", "prettier.config.mjs" } },
}

return M
