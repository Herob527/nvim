vim.keymap.set({ "n" }, "<leader>ha", function()
	vim.lsp.buf.hover({ border = "single", max_height = 25, max_width = 120 })
end, { desc = "Trigger [h]over [a]ction" })

local restart_command = function()
	local nvim_version = vim.version.parse(vim.system({ "nvim", "-v" }):wait().stdout)
	local nvim_version_new_lsp = vim.version.parse("0.12.0")
	local has_lsp_restart = vim.version.lt(
		{ nvim_version.major, nvim_version.minor, nvim_version.patch },
		{ nvim_version_new_lsp.major, nvim_version_new_lsp.minor, nvim_version_new_lsp.patch }
	)

	if has_lsp_restart then
		return ":LspRestart"
	else
		return ":lsp restart"
	end
end

local lsp_restart_command = restart_command()

vim.keymap.set({ "n", "v" }, "<leader>,", function()
	require("conform").format({ async = true })
end, { desc = "Trigger [L]SP formatting" })

vim.keymap.set({ "n" }, "<leader>ef", function()
	if not vim.fn.exists(":VtsExec") == 2 then
		vim.cmd("silent exec ':VtsExec restart_tsserver'")
		-- vim.cmd("silent exec ':VtsExec reload_project'")
	end
	vim.iter(vim.lsp.get_clients())
		:filter(function(client)
			return client.name ~= "vtsls"
		end)
		:each(function(client)
			vim.cmd("silent exec '" .. lsp_restart_command .. " " .. client.name .. "'")
		end)
	vim.diagnostic.reset()
end, { desc = "Reset LSP and diagnostics", silent = true })
