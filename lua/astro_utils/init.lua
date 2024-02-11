local M = {}
M.setup = function()
	vim.api.nvim_create_user_command("AddPage", require("astro_utils.commands.AddPage").func, { nargs = "?" })

	vim.keymap.set("n", "<leader>ap", "<cmd>AddPage<cr>")
end

return M
