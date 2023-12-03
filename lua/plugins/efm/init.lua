local M = {}

M.init = function()
	local eslint_d = require("efmls-configs.linters.eslint_d")
	local prettier_d = require("efmls-configs.formatters.prettier_d")
	local stylua = require("efmls-configs.formatters.stylua")
	local rustfmt = require("efmls-configs.formatters.rustfmt")
	local black = require("efmls-configs.formatters.black")
	local ruff_lint = require("efmls-configs.linters.ruff")
	local json_lint = require("efmls-configs.linters.jq")
	local yamllint = require("efmls-configs.linters.yamllint")

	local languages = {
		typescriptreact = { eslint_d, prettier_d },
		javascriptreact = { eslint_d, prettier_d },
		typescript = { eslint_d, prettier_d },
		javascript = { eslint_d, prettier_d },
		lua = { stylua },
		rust = { rustfmt },
		astro = { eslint_d, prettier_d },
		html = { prettier_d },
		vue = { prettier_d, eslint_d },
		python = { black, ruff_lint },
		json = { prettier_d, json_lint },
		yaml = { prettier_d, yamllint },
	}
	local efmls_config = {
		filetypes = vim.tbl_keys(languages),
		settings = {
			rootMarkers = { ".git/" },
			languages = languages,
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
		},
	}

	require("lspconfig").efm.setup(vim.tbl_extend("force", efmls_config, {
		on_attach = require("lsp-format").on_attach,
	}))
end

M.config = {
	"mattn/efm-langserver",
	event = "VeryLazy",
	build = "go install github.com/mattn/efm-langserver@latest",
	dependencies = {
		{
			"creativenull/efmls-configs-nvim",
			version = "v1.x.x", -- version is optional, but recommended
			dependencies = {
				"neovim/nvim-lspconfig",
			},
		},
	},
	config = function()
		M.init()
	end,
}
return M
