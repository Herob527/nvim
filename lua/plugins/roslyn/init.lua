local M = {}

M.config = {
	"GustavEikaas/easy-dotnet.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	event = "VeryLazy",
	config = function()
		require("easy-dotnet").setup()
	end,
}

return M
