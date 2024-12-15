local mason = {
	"williamboman/mason.nvim",
	event = "VeryLazy",
	config = function()
		require("mason").setup({
			ui = {
				border = "rounded",
			},
		})
	end,
}

return mason
