local M = {}
M.launch_ui = function()
	local Input = require("nui.input")
	local event = require("nui.utils.autocmd").event

	local input = Input({
		position = "50%",
		size = {
			width = 32,
		},
		border = {
			style = "single",
			text = {
				top = "Name file to create / replace",
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:Normal",
		},
	}, {
		prompt = "> ",
		default_value = "",
		on_close = function()
			print("Input Closed!")
		end,
		on_submit = function(value)
			print("Input Submitted: " .. value)
		end,
		on_change = function(value)
			print("Value changed: ", value)
		end,
	})

	-- mount/open the component
	input:mount()

	-- unmount component when cursor leaves buffer
	input:on(event.BufLeave, function()
		input:unmount()
	end)
end

package.path = "AddPage.ui"

return M
