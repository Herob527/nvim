local M = {}

M.init = function()
	local langs = require("utils.langs_table").langs_iterator()

	local package_manager_map = {
		npm = "npm",
		pip = "pip",
		github = "curl",
		cargo = "cargo",
		go = "go",
	}

	local test = vim.iter(langs)
		:map(function(data)
			local lang = data[1]
			local content = data[2]
			if content.linter == nil then
				return nil
			end

			local linters = {}
			for _, linter in ipairs(content.linter) do
				if type(linter) == "table" then
					-- Check package manager executable
					local pkg_mgr = linter.package_manager
					local executable = package_manager_map[pkg_mgr]
					if executable and vim.fn.executable(executable) == 1 then
						table.insert(linters, linter.name)
					end
				else
					-- Backward compatibility: if it's just a string, add it
					table.insert(linters, linter)
				end
			end

			if #linters > 0 then
				return { [lang] = linters }
			else
				return nil
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
