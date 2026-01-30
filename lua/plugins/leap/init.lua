local M = {}

M.init = function()
	require("leap").add_default_mappings()
end

M.config = {
	"https://codeberg.org/andyg/leap.nvim",
	keys = { { "s" }, { "S" }, { "f" }, { "F" } },
	dependencies = {
		"tpope/vim-repeat",
	},
	config = function()
		M.init()
	end,
}

return M
