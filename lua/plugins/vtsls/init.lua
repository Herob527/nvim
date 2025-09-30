local M = {}

M.config = {
	"yioneko/nvim-vtsls",
	event = "LspAttach",
	config = function()
		require("lspconfig.configs").vtsls = require("vtsls").lspconfig
	end,
	dependencies = { "neovim/nvim-lspconfig" },
}

return M