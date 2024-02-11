local M = {}

local templates = {
	[[
---
interface Props {

}
---]],
}

local function write_page(path, template)
	local utils = require("astro_utils.utils")
	local lines = utils.lines
	vim.fn.delete(path)
	vim.fn.writefile(lines(template), path, "a")
end

--- @param name string
local function create_page(name)
	if name == nil or name == "" then
		error("No name provided")
		return
	end
	local utils = require("astro_utils.utils")
	local endswith = utils.endswith
	local cwd = vim.fn.getcwd()
	local pages_path = cwd .. "/src/pages/"
	local page_path = pages_path .. name
	-- Automatically add missing extension if not provided
	if not endswith(page_path, ".astro") then
		page_path = page_path .. ".astro"
	end

	--- Handle having slashes or backslashes (create parent dirs)
	if name:find("[/\\]") then
		vim.print("Creating parent directories...")
		vim.fn.mkdir(pages_path .. name, "p")
	end

	--- Handle file existence
	if vim.fn.findfile(page_path) then
		vim.ui.select({ "yes", "no" }, {
			prompt = "File exists.",
			format_item = function(item)
				if item == "yes" then
					return "Overwrite file"
				else
					return "Cancel"
				end
			end,
		}, function(choice)
			if choice == "yes" then
				write_page(page_path, templates[1])
				vim.print("Overwritten " .. page_path)
			else
				vim.print("File " .. page_path .. " not overwritten")
			end
		end)
		return
	end

	write_page(page_path, templates[1])
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
		vim.print("No astro config found")
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
