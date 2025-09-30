local M = {}

M.config = {
	"jinh0/eyeliner.nvim",
	event = "VeryLazy",
	config = function()
		require("eyeliner").setup({
			-- show highlights only after keypress
			highlight_on_key = true,

			-- dim all other characters if set to true (recommended!)
			dim = true,

			max_length = 9999,

			-- filetypes for which eyeliner should be disabled;
			-- e.g., to disable on help files:
			-- disabled_filetypes = {"help"}
			disable_buftypes = { "nofile", "NvimTree" },

			-- add eyeliner to f/F/t/T keymaps;
			-- see section on advanced configuration for more information
			default_keymaps = true,
		})
	end,
}

return M