local M = {}


M.launch_ui = function()
  local commons = require("astro_utils.commands.AddPage.common")
  local utils = require("astro_utils.utils")
  local path_exists = utils.path_exists
  local endswith = utils.endswith
  local Input = require("nui.input")
  local Layout = require("nui.layout")
  local Popup = require("nui.popup")

  local cwd = vim.fn.getcwd()
  local pages_path = cwd .. "/src/pages/"
  local popup_two = Popup({
    focusable = false,
    buf_options = {
      modifiable = true,
      readonly = false,
    },
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
      commons.create_page(value)
    end,
    on_change = function(value)
      if value == "" then
        return
      end
      vim.schedule(function()
        local result_value = value .. (endswith(value, ".astro") and "" or ".astro")

        local page_path = pages_path .. result_value
        local file_exists = path_exists(page_path)
        local error_msg = file_exists and "File already exists. Accepting input will overwrite it!" or ""
        vim.api.nvim_buf_set_lines(popup_two.bufnr, 0, -1, false,
          { "Output path: /src/pages/" .. result_value, "", error_msg })
        if error_msg ~= "" then
        vim.api.nvim_buf_add_highlight(popup_two.bufnr, 1, "error",  2, 0, -1)
      end
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
      Layout.Box(popup_two, { grow = 5 }),
    }, { dir = "col" })
  )
  -- mount/open the component
  layout:mount()
  input:on("BufLeave", function()
    layout:unmount()
  end)
end

package.path = "AddPage.ui"

return M
