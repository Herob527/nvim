vim.keymap.set({ "n" }, "<leader>ha", function()
	vim.lsp.buf.hover({ border = "single", max_height = 25, max_width = 120 })
end, { desc = "Trigger [h]over [a]ction" })

vim.keymap.set({ "n", "v" }, "<leader>,", function()
	require("conform").format({ async = true })
end, { desc = "Trigger [L]SP formatting" })

vim.keymap.set({ "n" }, "<leader>ef", function()
	if not vim.fn.exists(":VtsExec") == 2 then
		vim.cmd("silent exec ':VtsExec restart_tsserver'")
	end
	vim.iter(vim.lsp.get_clients()):each(function(client)
		vim.cmd("silent exec ':LspRestart " .. client.name .. "'")
	end)
	vim.diagnostic.reset()
end, { desc = "Reset LSP and diagnostics", silent = true })
