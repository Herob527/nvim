vim.keymap.set({ "n" }, "<leader>ha", vim.lsp.buf.hover, { desc = "Trigger [h]over [a]ction" })
vim.keymap.set({ "n", "v" }, "<leader>,", function()
	require("conform").format({ async = true })
end, { desc = "Trigger [L]SP formatting" })

vim.keymap.set({ "n" }, "<leader>ef", function()
	if not vim.fn.exists(":VtsExec") == 2 then
		vim.cmd("silent exec ':VtsExec restart_tsserver'")
	end
	vim.cmd("silent exec ':LspRestart'")
	vim.diagnostic.reset()
end, { desc = "Reset LSP and diagnostics", silent = true })
