local M = {}

M.init = function()
	local coq = require("coq")
	vim.g.coq_settings = {
		limits = {
			completion_auto_timeout = 0.2,
		},
		display = { pum = { fast_close = false } },
		clients = {
			lsp = {
				enabled = true,
			},
			tree_sitter = {
				enabled = true,
				weight_adjust = 1.0,
			},
			tabnine = {
				enabled = false,
			},
		},
	}
	vim.cmd([[COQnow -s]])
end

M.config = {
	"ms-jpq/coq_nvim",
	dependencies = {
		"ms-jpq/coq.artifacts",
	},
	event = "InsertCharPre",
	config = function()
		M.init()
	end,
}
return M
