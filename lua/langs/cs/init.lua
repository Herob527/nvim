local M = {}

M.treesitter = {
	"c_sharp",
}

M.lspconfig = {
	-- { lsp = "roslyn" },
	-- { lsp = "csharp_ls" },
}

M.mason = {
	"roslyn",
}

M.mason.lspconfig = {
	-- "roslyn",
	-- "csharp_ls",
}

return M
