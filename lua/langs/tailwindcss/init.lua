local M = {}

M.treesitter = {}

M.lspconfig = {
	{
		lsp = "tailwindcss",
		settings = {
			tailwindCSS = {
				classAttributes = { "class-name", "class", "className", "class:list" },
			},
		},
	},
}

M.mason = {}

M.mason.lspconfig = {
	"tailwindcss",
}

M.conform = {
	"rustywind",
}

return M
