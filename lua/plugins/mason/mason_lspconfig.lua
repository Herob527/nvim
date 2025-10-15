local mason_lspconfig = {
	"williamboman/mason-lspconfig.nvim",
	event = "VeryLazy",
	config = function()
		local mason_lsp = require("mason-lspconfig")

		local package_manager_map = {
			npm = "npm",
			pip = "pip",
			github = "curl",
			cargo = "cargo",
			go = "go",
		}

		local langs = require("utils.langs_table").langs_iterator()
		local mason_lspconfig_entries = {}
		for data in langs do
			for _, lspdata in pairs(data[2].mason.lspconfig or {}) do
				if type(lspdata) == "table" then
					local pkg_mgr = lspdata.package_manager
					local executable = package_manager_map[pkg_mgr]
					if executable and vim.fn.executable(executable) == 1 then
						table.insert(mason_lspconfig_entries, lspdata.name)
					end
				else
					-- Backward compatibility: if it's just a string, add it
					table.insert(mason_lspconfig_entries, lspdata)
				end
			end
		end

		mason_lsp.setup({
			ensure_installed = mason_lspconfig_entries,
			automatic_installation = true,
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
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "LspInfo", "LspInstall", "LspUninstall" },
	build = function()
		local install_npm_package = require("utils.install_npm_package")
		install_npm_package("@vue/typescript-plugin")
	end,
}
