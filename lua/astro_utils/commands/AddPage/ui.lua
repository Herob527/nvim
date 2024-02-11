local M = {}
M.launch_ui = function()
	local Input = require("nui.input")
	local Layout = require("nui.layout")
	local Popup = require("nui.popup")

	local popup_two = Popup({
		focusable = true,
		zindex = 50,
		mode = "action",
		relative = "editor",
		border = {
			padding = {
				top = 1,
				left = 2,
				right = 1,
			},
			style = "rounded",
			text = {
				top = " Status ",
				top_align = "left",
			},
		},
	})
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
			if value == "" then
				return
			end
			vim.schedule(function()
				local ok, data = pcall(vim.api.nvim_buf_set_lines, popup_two.bufnr, 0, 2, false, { value })

				vim.print("Value changed: " .. value, ok, data)
			end)
		end,
	})
	local layout = Layout(
		{
			position = "50%",
			size = {
				width = 80,
				height = "40%",
			},
		},
		Layout.Box({
			Layout.Box(input, { grow = 1 }),
			Layout.Box(popup_two, { grow = 4 }),
		}, { dir = "col" })
	)
	-- mount/open the component
	layout:mount()
	input:on("BufLeave", function()
		popup_two:unmount()
		input:unmount()
		layout:unmount()
	end)
end

package.path = "AddPage.ui"

return M
