local M = {}

M.config = {
	"dmmulroy/tsc.nvim",
	config = function()
		require("tsc").setup()
	end,
	event = "LspAttach",
}

return M