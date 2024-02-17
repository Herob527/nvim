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
--- @param file_exists_handler? fun(path: string): boolean If function returns *true*, overwrite file - If not provided, it'll overwrite file by default
M.create_page = function(name, file_exists_handler)
  if name == nil or name == "" then
    error("No name provided")
    return
  end
  local utils = require("astro_utils.utils")
  local endswith = utils.endswith
  local path_exists = utils.path_exists
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
  if path_exists(page_path) then
    if file_exists_handler then
      local overwrite = file_exists_handler(page_path)
      if overwrite then
        M.write_page(page_path, templates[1])
      end
    else
      M.write_page(page_path, templates[1])
    end
    return
  end

  M.write_page(page_path, templates[1])
end

package.path = "AddPage.common"

return M
