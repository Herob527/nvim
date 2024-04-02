
--- @param package_name string
local function install_npm_package(package_name)
  local plenary = require("plenary")
  local path = plenary.path:new(vim.fn.stdpath("data"), "lazy", "packages")
  path:mkdir()
  local package_path = path:absolute()
  local job = plenary.job:new({
    command = "npm",
    args = { "install", package_name },
    cwd = package_path,
    on_exit = function(j, return_val)
      if return_val == 0 then
        print("Successfully installed " .. package_name)
      else
        print("Failed to install " .. package_name)
      end
    end,
  })

  job:start()
end

return install_npm_package
