local M = {}

M.config = {
	"seblyng/roslyn.nvim",
	event = "VeryLazy",
	---@module 'roslyn.config'
	---@type RoslynNvimConfig
	config = function()
		vim.lsp.config("roslyn", {
			on_attach = function()
				print("This will run when the server attaches!")
			end,
			settings = {
				["csharp|inlay_hints"] = {
					csharp_enable_inlay_hints_for_implicit_object_creation = true,
					csharp_enable_inlay_hints_for_implicit_variable_types = true,
				},
				["csharp|code_lens"] = {
					dotnet_enable_references_code_lens = true,
				},
			},
		})
	end,
	opts = {
		-- your configuration comes here; leave empty for default settings
	},
}

return M