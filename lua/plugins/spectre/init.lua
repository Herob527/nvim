local M = {}

M.init = function()
	require("grug-far").setup({})
end
M.config = {
	"MagicDuck/grug-far.nvim",
	keys = {
		{
			"<leader>S",
			"<cmd>GrugFar ripgrep<CR>",
			desc = "Open ripgrep",
		},
		{
			"<leader>G",
			"<cmd>GrugFar astgrep<CR>",
			desc = "Open astgrep",
		},
	},
	config = function()
		M.init()
	end,
}
return M
