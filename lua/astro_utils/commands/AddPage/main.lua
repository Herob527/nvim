local M = {}

M.func = function(opts)
	local split_args = require("astro_utils.utils").split_args
	local args = split_args(opts.args)

	if #args > 1 then
		error("Too many arguments. This function accepts one")
		return
	end

	if args[1] == "-ui" then
		require("astro_utils.commands.AddPage.ui").launch_ui()
	else
		require("astro_utils.commands.AddPage.cmd").launch_cmd(args)
	end
end

return M
