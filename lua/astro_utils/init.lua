local M = {}

M.setup = function()
	local cwd = vim.fn.getcwd()
	local astro_config_path = cwd .. "/astro.config.mjs"
	if vim.fn.filereadable(astro_config_path) == 0 then
		return
	end

	vim.api.nvim_create_user_command("AddPage", require("astro_utils.commands.AddPage.main").func, { nargs = "?" })

	vim.keymap.set("n", "<leader>ap", "<cmd>AddPage -ui<cr>")
end

return M
