local M = {}

M.config = {
	"kosayoda/nvim-lightbulb",
	event = "LspAttach",
	config = function()
		require("nvim-lightbulb").setup({
			autocmd = { enabled = true },
		})
	end,
}

return M