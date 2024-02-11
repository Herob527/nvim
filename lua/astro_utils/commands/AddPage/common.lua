local M = {}

local templates = {
	[[
---
interface Props {

}
---]],
}

M.write_page = function(path, template)
	local utils = require("astro_utils.utils")
	local lines = utils.lines
	vim.fn.delete(path)
	vim.fn.writefile(lines(template), path, "a")
end

--- @param name string
M.create_page = function(name)
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
				M.write_page(page_path, templates[1])
				vim.print("Overwritten " .. page_path)
			else
				vim.print("File " .. page_path .. " not overwritten")
			end
		end)
		return
	end

	M.write_page(page_path, templates[1])
end

return M
