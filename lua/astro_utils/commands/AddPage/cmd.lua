local M = {}

M.launch_cmd = function(args)
	local common = require("astro_utils.commands.AddPage.common")
	if #args == 1 and args[1] ~= "" then
		common.create_page(args[1])
	else
		vim.ui.input({ prompt = "Page name: " }, function(page_name)
			common.create_page(page_name)
		end)
	end
end

package.path = "AddPage.cmd"

return M
