local M = {}

M.config = {
	"nvim-flutter/flutter-tools.nvim",
	lazy = false,
	keys = {
		{ "<leader>tr", "<cmd>FlutterRun<cr>", desc = "Flu[t]ter [r]un" },
		{ "<leader>tl", "<cmd>FlutterLogToggle<cr>", desc = "Flu[t]ter [l]og" },
		{ "<leader>tcl", "<cmd>FlutterLogClear<cr>", desc = "Flu[t]ter [c]lear [l]og" },
		{ "<leader>tR", "<cmd>FlutterRestart<cr>", desc = "Flu[t]ter [R]estart" },
		{ "<leader>tq", "<cmd>FlutterQuit<cr>", desc = "Flu[t]ter [q]uit" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = true,
}

return M
