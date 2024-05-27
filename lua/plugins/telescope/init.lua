local M = {}

M.init = function()
	local telescope = require("telescope")
	local previewers = require("telescope.previewers")

	local new_maker = function(filepath, bufnr, opts)
		opts = opts or {}

		filepath = vim.fn.expand(filepath)
		vim.loop.fs_stat(filepath, function(_, stat)
			if not stat then
				return
			end
			local max_size = 1024 * 200 -- 200kB max
			if stat.size > max_size then
				return
			else
				previewers.buffer_previewer_maker(filepath, bufnr, opts)
			end
		end)
	end

	telescope.setup({
		defaults = {
			file_ignore_patterns = { ".git/.+", "node_modules", "dist", "^.git$" },
			buffer_previewer_maker = new_maker,
		},
		pickers = {
			find_files = {
				hidden = true,
				find_command = { "rg", "--files" },
			},
			live_grep = {
				debounce = 250,
				find_command = { "rg" },
			},
		},
	})
end

M.config = {
	"nvim-telescope/telescope.nvim",
	keys = {

		{ "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "[F]ind [f]iles" },
		{ "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "[F]ind [g]reps" },
		{ "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "[F]ind [b]uffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "[F]ind [h]elp" },
		{ "<leader>fr", "<cmd>Telescope lsp_references<CR>", desc = "[F]ind [r]eferences" },
		{ "<leader>fn", "<cmd>Telescope lsp_definitions<CR>", desc = "[F]ind defi[n]itions" },
	},
	event = "VeryLazy",
	config = function()
		M.init()
	end,
}

return M
