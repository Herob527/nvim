local M = {}

M.treesitter = { "lua" }

M.lspconfig = {
	{
		lsp = "lua_ls",
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	},
}
M.mason = {}
M.mason.lspconfig = {
	{ name = "lua_ls", package_manager = "github" },
}

M.conform = {
	{ name = "stylua", package_manager = "github" },
}

M.linter = {
	{ name = "selene", package_manager = "github" },
}

return M
