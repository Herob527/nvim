local M = {}

M.init = function()
	local status_ok, bufferline = pcall(require, "bufferline")
	if not status_ok then
		return
	end
	local map = vim.api.nvim_set_keymap

	local diagnostics_indicator = function(_count, _level, diagnostics_dict, _context)
		local str = ""
		if diagnostics_dict == nil then
			return ""
		end
		if diagnostics_dict.error ~= nil and diagnostics_dict.error >= 0 then
			str = str .. "" .. " " .. diagnostics_dict.error
		end
		if diagnostics_dict.warning ~= nil and diagnostics_dict.warning >= 0 then
			str = str .. " " .. " " .. diagnostics_dict.warning
		end
		return str
	end

	map("n", "<C-l>", "<cmd>:BufferLineCycleNext<cr>", { desc = "Next Tab" })
	map("n", "<C-k>", "<cmd>:BufferLineCyclePrev<cr>", { desc = "Previous Tab" })
	map("n", "<leader>;", "<cmd>:BufferLineCloseRight<cr>", { desc = "Close tabs to the right" })
	map("n", "<leader>k", "<cmd>:BufferLineCloseLeft<cr>", { desc = "Close tabs to the left" })

	bufferline.setup({
		options = {
			diagnostics = "nvim_lsp",
			diagnostics_indicator = diagnostics_indicator,
		},
	})
end

M.config = {
	"akinsho/bufferline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
		config = function()
			require("nvim-web-devicons").setup({
				override_by_filename = {
					["prettier"] = {
						icon = "",
						color = "#f1502f",
						name = "Gitignore",
					},
				},
				override_by_extension = {
					["astro"] = {
						icon = "󰑣",
						color = "#FF5733",
						name = "AstroIcon",
					},
					[".nvmrc"] = {
						icon = "",
						color = "#00a2ff",
						name = "nvmrcIcon",
					},
				},
			})
		end,
	},
	event = "BufAdd",
	config = function()
		M.init()
	end,
}

return M
