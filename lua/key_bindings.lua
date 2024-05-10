local opts = { noremap = true, silent = true }

vim.keymap.set({ "n" }, "<leader>ha", vim.lsp.buf.hover, { desc = "Trigger [h]over [a]ction" })
vim.keymap.set({ "n" }, "<leader>,", vim.lsp.buf.format, { desc = "Trigger [L]SP formatting" })

vim.keymap.set({ "n" }, "<leader>ef", function()
	vim.cmd("silent exec ':LspRestart'")
	vim.diagnostic.reset()
end, { desc = "Reset eslint_d and diagnostics", silent = true })
