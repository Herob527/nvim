local M = {}

local templates = {
	[[
---
interface Props {

}
---]],
}

local function create_page(name)
	if name == nil or name == "" then
		error("No name provided")
		return
	end
	local utils = require("astro_utils.utils")
	local lines = utils.lines
	local endswith = utils.endswith
	local cwd = vim.fn.getcwd()
	local page_path = cwd .. "/src/pages/" .. name
	if not endswith(page_path, ".astro") then
		page_path = page_path .. ".astro"
	end

	local dummy_content = templates[1]
	vim.fn.delete(page_path)
	vim.fn.writefile(lines(dummy_content), page_path, "a")
end

M.func = function(opts)
	local cwd = vim.fn.getcwd()
	local astro_config_path = cwd .. "/astro.config.mjs"

	local utils = require("astro_utils.utils")
	local split_args = utils.split_args
	local args = split_args(opts.args)
	if #args > 1 then
		error("Too many arguments. This function accepts one")
		return
	end

	if vim.fn.filereadable(astro_config_path) == 0 then
		return
	end
	print(args[1])
	if #args == 1 and args[1] ~= "" then
		create_page(args[1])
	else
		vim.ui.input({ prompt = "Page name: " }, function(page_name)
			create_page(page_name)
		end)
	end
end

return M
