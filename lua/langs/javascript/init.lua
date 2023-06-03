require("nvim-treesitter.configs").setup({
	ensure_installed = { "javascript", "typescript", "tsx", "jsdoc" },
	auto_install = true,
})

require("mason-lspconfig").setup({
	ensure_installed = { "tsserver" },
	automatic_installation = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig")["tsserver"].setup({
	capabilities = capabilities,
})
