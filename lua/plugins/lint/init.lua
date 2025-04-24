local M = {}

M.init = function()
	local langs = require("utils.langs_table").langs_iterator()
	local test = vim.iter(langs)
		:map(function(data)
			local lang = data[1]
			local content = data[2]
			if content.linter == nil then
				return nil
			else
				return { [lang] = content.linter }
			end
		end)
		:filter(function(data)
			return data ~= nil
		end)
		:totable()

	local linters = {}

	for k in pairs(test) do
		linters = vim.tbl_extend("force", linters, test[k])
	end
	require("lint").linters_by_ft = linters

	vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
		callback = function()
			-- try_lint without arguments runs the linters defined in `linters_by_ft`
			-- for the current filetype
			require("lint").try_lint()
		end,
	})
end

M.config = {
	"mfussenegger/nvim-lint",
	event = "VeryLazy",
	config = function()
		M.init()
	end,
	dependencies = {
		{
			"rshkarin/mason-nvim-lint",
			config = function()
				require("mason-nvim-lint").setup()
			end,
		},
	},
}

return M
