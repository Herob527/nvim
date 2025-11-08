local M = {}

M.lspconfig = {}

M.mason = {}

M.mason.lspconfig = {}

M.treesitter = { "xml" }

M.conform = {
	{ name = "xmlformatter", package_manager = "pip" },
}

return M
