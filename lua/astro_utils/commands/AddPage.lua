local M = {}

local templates = {
	[[
---
interface Props {

}
---]],
}

--- @param name string
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
	if vim.fn.findfile(page_path) then
		vim.ui.select({ "yes", "no" }, { prompt = "File exists. Overwrite?" }, function(choice)
			if choice == "yes" then
				print("\nOverwriting " .. page_path)
				local dummy_content = templates[1]
				vim.fn.delete(page_path)
				vim.fn.writefile(lines(dummy_content), page_path, "a")
			else
				print("\nFile " .. page_path .. " not overwritten")
			end
		end)
		return
	end

	local dummy_content = templates[1]
	vim.fn.delete(page_path)
	vim.fn.writefile(lines(dummy_content), page_path, "a")
end

M.func = function(opts)
	local split_args = require("astro_utils.utils").split_args
	local cwd = vim.fn.getcwd()
	local astro_config_path = cwd .. "/astro.config.mjs"
	local args = split_args(opts.args)

	if #args > 1 then
		error("Too many arguments. This function accepts one")
		return
	end

	if vim.fn.filereadable(astro_config_path) == 0 then
		print("No astro config found")
		return
	end

	if #args == 1 and args[1] ~= "" then
		create_page(args[1])
	else
		vim.ui.input({ prompt = "Page name: " }, function(page_name)
			create_page(page_name)
		end)
	end
end

return M
