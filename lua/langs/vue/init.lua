local M = {}

M.treesitter = { "vue" }

M.lspconfig = {
  { lsp = "volar" },
  { lsp = "eslint" },
}

M.mason = {}

M.mason.lspconfig = {
  "volar",
  "eslint",
}

M.mason.null_ls = {
  "prettierd",
}

M.null_ls = {
  formatting = { { program = "prettierd", with = { filetypes = { "vue" } } } },
}
return M
