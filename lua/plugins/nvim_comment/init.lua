local M = {}

M.init = function()
	require("Comment").setup()
end

M.config = {
	"numToStr/Comment.nvim",
	event = "BufNew",
	config = M.init,
}

return M
