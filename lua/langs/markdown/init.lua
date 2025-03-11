local M = {}

M.treesitter = { "markdown" }

M.lspconfig = {
	{ lsp = "marksman" },
}

M.mason = {}

M.mason.lspconfig = {
	"marksman",
	"mdx_analyzer",
}

M.conform = {
	{ name = "prettierd", requires = { ".prettierc" } },
	"markdownlint",
}

M.linter = {
	"markdownlint",
}

return M
