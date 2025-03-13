local M = {}

M.init = function()
	local langs = require("utils.langs_table")
	local project_marker = { ".git", "package.json", "pyproject.toml" }
	local project_root = vim.fs.root(0, project_marker)
	local test = vim.iter(langs)
		:map(function(lang, content)
			if content.conform == nil or vim.tbl_isempty(content.conform) then
				return nil
			-- TODO: Make this flexible allowing more formatters follow this
			elseif project_root ~= nil and type(content.conform[1]) == "table" then
				local has_requires = vim.iter(content.conform[1].requires)
					:map(function(item)
						return project_root .. "/" .. item
					end)
					:any(function(item)
						return vim.fn.filereadable(item) == 1
					end)

				if has_requires then
					return { [lang] = { content.conform[1].name } }
				else
					return nil
				end
			else
				-- vim.print(content.conform)
				return { [lang] = content.conform }
			end
		end)
		:filter(function(data)
			return data ~= nil
		end)
		:totable()

	local formatters = {}

	for k in pairs(test) do
		formatters = vim.tbl_extend("force", formatters, test[k])
	end

	require("conform").setup({
		format_after_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters_by_ft = formatters,
	})
end

M.config = {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	config = function()
		M.init()
	end,
	dependencies = {
		{
			"zapling/mason-conform.nvim",
			event = "VeryLazy",
			config = function()
				require("mason-conform").setup()
			end,
		},
	},
}

return M
