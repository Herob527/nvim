local M = {}

M.treesitter = {}

M.lspconfig = {
	{
		lsp = "tailwindcss",
		settings = function()
			local nuxt_tailwind_path = "assets/css/main.css"

			local nuxt_config = { "nuxt.config.ts" }
			local project_root = vim.fs.root(0, nuxt_config)
			local apply_nuxt_tailwind = project_root ~= nil
					and (vim.fn.filereadable(project_root .. "/" .. nuxt_tailwind_path) == 1)
				or false
			return {
				tailwindCSS = {
					classAttributes = { "class-name", "class", "className", "class:list" },
					experimental = {
						configFile = apply_nuxt_tailwind and nuxt_tailwind_path or nil,
					},
				},
			}
		end,
	},
}

M.mason = {}

M.mason.lspconfig = {
	"tailwindcss",
}

M.conform = {
	"rustywind",
}

return M
