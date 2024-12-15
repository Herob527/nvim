local mason_lspconfig = {
	"williamboman/mason-lspconfig.nvim",
	event = "VeryLazy",
	config = function()
		local mason_lsp = require("mason-lspconfig")

		local langs_table = require("utils.langs_table")
		local mason_lspconfig_entries = {}
		for _, data in pairs(langs_table) do
			for _, lspdata in pairs(data.mason.lspconfig) do
				table.insert(mason_lspconfig_entries, lspdata)
			end
		end

		mason_lsp.setup({
			ensure_installed = mason_lspconfig_entries,
			automatic_installation = true,
		})
	end,
	dependencies = {
		require("lazy.config_parts.mason_config"),
	},
}

local lsp_config_iterator = function()
	local langs_table = require("utils.langs_table")
	local languages = {}

	for lang, init in pairs(langs_table) do
		table.insert(languages, { language = lang, init = init })
	end

	local lang_idx = 1
	local lsp_idx = 0

	return function()
		lsp_idx = lsp_idx + 1

		if lsp_idx > #languages[lang_idx].init.lspconfig then
			lsp_idx = 1
			lang_idx = lang_idx + 1
		end

		if lang_idx <= #languages then
			--- General data about language
			local current_lang = languages[lang_idx]
			--- Data about lsp_config only
			local current_lsp_data = current_lang.init.lspconfig[lsp_idx]
			return current_lang, current_lsp_data
		else
			return nil
		end
	end
end

local lspconfig = {
	"neovim/nvim-lspconfig",
	dependencies = { mason_lspconfig, {
		"b0o/schemastore.nvim",
	} },
	priority = 700,
	event = "VeryLazy",
	build = function()
		local install_npm_package = require("utils.install_npm_package")
		install_npm_package("@vue/typescript-plugin")
	end,
	config = function()
		local lsp_config = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local iter = lsp_config_iterator()

		for _, lsp_data in iter do
			if lsp_data.lsp then
				local params = {
					capabilities = capabilities,
				}
				if lsp_data.settings then
					params.settings = lsp_data.settings
				end
				if lsp_data.init_options then
					params.init_options = lsp_data.init_options
				end
				if lsp_data.before_init then
					params.before_init = lsp_data.before_init
				end
				if lsp_data.filetypes then
					params.filetypes = lsp_data.filetypes
				end
				lsp_config[lsp_data.lsp].setup(params)
			end
		end
	end,
}
return lspconfig
