local M = {}

M.treesitter = { "yaml" }

M.lspconfig = {
	{
		lsp = "yamlls",
		settings = {
			yaml = {
				schemaStore = {
					-- You must disable built-in schemaStore support if you want to use
					-- this plugin and its advanced options like `ignore`.
					enable = false,
					-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
					url = "",
				},
			},
		},
	},
}

M.mason = {}

M.mason.lspconfig = {
	"yamlls",
}

M.mason.null_ls = {
	"yamllint",
	"yamlfmt",
	"prettierd",
}

M.null_ls = {
	formatting = { { program = "prettierd", with = { filetypes = { "yaml" } } } },
	diagnostics = {
		{
			program = "yamllint",
			with = {
				args = {
					"--format",
					"parsable",
					"--config-file",
					os.getenv("HOME") .. "/.config/nvim/lua/langs/yaml/yamllint_config.yml",
					"--no-warnings",
					"-",
				},
			},
		},
	},
}

return M
