local M = {}

M.init = function()
	-- require("leap").add_default_mappings()
	vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
	vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
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
