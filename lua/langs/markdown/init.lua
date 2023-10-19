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

M.mason.null_ls = {
	"markdownlint",
}

M.null_ls = {
	formatting = {
		{ program = "markdownlint" },
		{ program = "prettierd", with = { filetypes = { "markdown", "mdx" } } },
	},
	diagnostics = { { program = "markdownlint" } },
}
return M
