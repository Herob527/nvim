local M = {}

M.init = function()
  local langs = require("utils.langs_table")
  local test = vim.iter(langs)
      :map(function(lang, content)
        if content.conform == nil then
          return nil
        else
          return { [lang] = content.conform }
        end
      end)
      :filter(function(data) return data ~= nil end)
      :totable()

  local formatters = {}

  for k in pairs(test) do
    formatters = vim.tbl_extend('force', formatters, test[k])
  end

  require("conform").setup({
    format_after_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
    formatters_by_ft = formatters,
  })
end

M.config = {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    M.init()
  end
}

return M
