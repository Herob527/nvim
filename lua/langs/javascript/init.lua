local M = {}

M.filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }

M.treesitter = { "javascript", "typescript", "tsx", "jsdoc" }

M.lspconfig = {
	{
		lsp = "vtsls",
		settings = {
			vtsls = {
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
		lsp = "eslint",
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
	},

	{
		lsp = "oxlint",
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
	},
	{
		lsp = "biome",
	},
}

M.mason = {}

M.mason.lspconfig = {
	{ name = "vtsls", package_manager = "npm" },
	{ name = "oxlint", package_manager = "npm" },
	{ name = "eslint", package_manager = "npm" },
	{ name = "biome", package_manager = "npm" },
}

M.conform = {
	{
		name = "prettierd",
		requires = { ".prettierrc", ".prettierrc.json", "prettier.config.mjs" },
		package_manager = "npm",
	},
	{
		name = "biome",
		package_manager = "npm",
		requires = { "biome.json" },
	},
}

return M
