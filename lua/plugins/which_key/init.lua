local M = {}

M.init = function()
	require("which-key").setup({
		marks = true, -- shows a list of your marks on ' and `
		presets = {
			operators = true, -- adds help for operators like d, y, ...
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
		opts = {
			win = {
				border = "single", -- none, single, double, shadow
				position = "bottom", -- bottom, top
				margin = { 0, 0, 0, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
				padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
				winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
				zindex = 1000, -- positive value to position WhichKey above other floating windows.
			},
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 4, max = 25 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "center", -- align columns left, center or right
		},
	})
end

M.config = {
	"folke/which-key.nvim",
	cmd = "WhichKey",
	keys = { { "<leader>" }, { '"' }, { "`" }, { "d" }, { "z" }, { "c" }, { "v" }, { "g" }, { "y" }, { "!" } },
	dependencies = { "echasnovski/mini.icons" },
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		M.init()
	end,
}
return M
