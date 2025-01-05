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
	"markdownlint",
	"prettierd",
}

M.linter = {
	"markdownlint",
}

return M
