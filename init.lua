require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use("nvim-treesitter/nvim-treesitter")

	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig")

	use("hrsh7th/cmp-nvim-lsp")
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
		},
	})
	use({
		"L3MON4D3/LuaSnip",
	})
	use("nvim-lua/plenary.nvim")
	use("jose-elias-alvarez/null-ls.nvim")
	use("jay-babu/mason-null-ls.nvim")
end)

require("key_bindings")
require("opts")

require("mason").setup({})
-- Plugins setup
require("plugins.treesitter.init")
require("plugins.cmp.init")

-- Languages setup
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.completion.luasnip,
	},
})

require("langs.javascript.init")

require("snippets.javascript.init")
