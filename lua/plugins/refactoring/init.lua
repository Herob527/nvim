local M = {}

M.init = function()
	require("refactoring").setup()
end

M.config = {
	"ThePrimeagen/refactoring.nvim",
	cmd = "Refactor",
	dependencies = {
		"lewis6991/async.nvim",
	},
	config = M.init,
}

return M
