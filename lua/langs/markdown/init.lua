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
	require("plugins.conform.formatters").prettierd,
	"markdownlint",
}

M.linter = {
	"markdownlint",
}

return M
