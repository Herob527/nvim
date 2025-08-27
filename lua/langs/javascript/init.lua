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
}

M.mason = {}

M.mason.lspconfig = {
	"vtsls",
	"eslint",
}

M.conform = {
	{ name = "prettierd", requires = { ".prettierrc", ".prettierrc.json", "prettier.config.mjs" } },
	{ name = "biome", requires = { "biome.json" } },
}

M.linter = {
	"biomejs",
}

return M
