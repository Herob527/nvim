local M = {}

M.config = {
	"aznhe21/actions-preview.nvim",
	keys = {
		{
			"<leader>ca",
			'<cmd>:lua require("actions-preview").code_actions()<CR>',
			mode = { "n", "v" },
			desc = "[C]ode [A]ction",
		},
	},
}

return M
