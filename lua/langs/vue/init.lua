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
	{ lsp = "volar" },
	{ lsp = "eslint" },
}

M.mason = {
	"vtsls",
}

M.mason.lspconfig = {
	"volar",
	"eslint",
}

M.conform = {
	{ name = "prettierd", requires = { ".prettierc", "prettier.config.mjs" } },
}

return M
