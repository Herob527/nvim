local M = {}

M.config = {
	"sudo-tee/opencode.nvim",
	event = "VeryLazy",
	config = function()
		require("opencode").setup({})
	end,
	dependencies = {
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				anti_conceal = { enabled = false },
				file_types = { "markdown", "opencode_output" },
			},
			ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
		},
		-- Optional, for file mentions and commands completion, pick only one
		"saghen/blink.cmp",

		-- Optional, for file mentions picker, pick only one
		"nvim-telescope/telescope.nvim",
	},
}

return M
