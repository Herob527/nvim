local mason_lspconfig = {
	"mason-org/mason-lspconfig.nvim",
	lazy = false,
	config = function()
		local mason_lsp = require("mason-lspconfig")

		local mason_lspconfig_entries = {}

		local package_manager_map = {
			npm = "npm",
			pip = "pip",
			github = "curl",
			cargo = "cargo",
			go = "go",
		}

		local langs = require("utils.langs_table").langs_iterator()
		for data in langs do
			for _, lspdata in pairs(data[2].mason.lspconfig or {}) do
				local pkg_mgr = lspdata.package_manager
				local executable = package_manager_map[pkg_mgr]
				if executable and vim.fn.executable(executable) == 1 then
					table.insert(mason_lspconfig_entries, lspdata.name)
				end
			end
		end

		mason_lsp.setup({
			ensure_installed = mason_lspconfig_entries,
			automatic_installation = true,
			automatic_enable = false,
		})
	end,
	dependencies = {
		require("plugins.mason.mason_config"),
	},
}

return {
	"neovim/nvim-lspconfig",
	dependencies = { mason_lspconfig, {
		"b0o/schemastore.nvim",
		"saghen/blink.cmp",
	} },
	priority = 700,
	event = { "VeryLazy" },
	cmd = { "LspInfo", "LspInstall", "LspUninstall" },
	config = function()
		local langs = require("utils.langs_table").langs_iterator()
		for data in langs do
			for _, lspconfig in pairs(data[2].lspconfig or {}) do
				local lsp = lspconfig.lsp
				local update_data = {}
				if lspconfig.settings ~= nil then
					update_data.settings = type(lspconfig.settings) == "function" and lspconfig.settings()
						or lspconfig.settings
				end
				if vim.tbl_count(update_data) > 0 then
					vim.lsp.config(lsp, update_data)
				end
				vim.lsp.enable(lsp)
			end
		end
	end,
	build = function()
		local install_npm_package = require("utils.install_npm_package")
		install_npm_package("@vue/typescript-plugin")
	end,
}
