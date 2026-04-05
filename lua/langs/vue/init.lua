local M = {}

M.treesitter = { "vue" }

local vue_language_server_path = vim.fn.stdpath("data")
	.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vue_language_server_path,
	languages = { "vue" },
	configNamespace = "typescript",
}

M.lspconfig = {
	{
		lsp = "vtsls",
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
			"vue",
		},
		settings = {
			vtsls = {
				tsserver = {
					globalPlugins = {
						vue_plugin,
					},
				},
				experimental = {
					maxInlayHintLength = 30,
					completion = {
						enableServerSideFuzzyMatch = true,
					},
				},
			},
			typescript = {
				inlayHints = {
					parameterNames = { enabled = "literals" },
					parameterTypes = { enabled = true },
					variableTypes = { enabled = false },
					propertyDeclarationTypes = { enabled = true },
					functionLikeReturnTypes = { enabled = true },
					enumMemberValues = { enabled = true },
				},
			},
			javascript = {
				inlayHints = {
					parameterNames = { enabled = "literals" },
					parameterTypes = { enabled = true },
					variableTypes = { enabled = false },
					propertyDeclarationTypes = { enabled = true },
					functionLikeReturnTypes = { enabled = true },
					enumMemberValues = { enabled = true },
				},
			},
		},
	},
	{
		lsp = "vue_ls",
	},
	{ lsp = "eslint" },
}

M.mason = {}

M.mason.lspconfig = {
	{ name = "eslint", package_manager = "npm" },
	{ name = "vtsls", package_manager = "npm" },
	{ name = "vue_ls", package_manager = "npm" },
}

M.conform = {
	{
		name = "prettierd",
		requires = { ".prettierrc", ".prettierrc.json", "prettier.config.mjs" },
		package_manager = "npm",
	},
}

return M
