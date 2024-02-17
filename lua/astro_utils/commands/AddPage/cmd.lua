local M = {}

local on_exist_handler = function(page_path)
	local value = false
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
			value = true
			vim.print("File " .. page_path .. " overwritten")
		else
			vim.print("File " .. page_path .. " not overwritten")
		end
	end)
	return value
end

M.launch_cmd = function(args)
	local common = require("astro_utils.commands.AddPage.common")
	if #args == 1 and args[1] ~= "" then
		common.create_page(args[1], on_exist_handler)
	else
		vim.ui.input({ prompt = "Page name: " }, function(page_name)
			common.create_page(page_name, on_exist_handler)
		end)
	end
end

package.path = "AddPage.cmd"

return M
