local M = {}

M.config = {
	"MysticalDevil/inlay-hints.nvim",
	event = "LspAttach",
	dependencies = { "neovim/nvim-lspconfig" },
	config = function()
		require("inlay-hints").setup()
	end,
}

return M