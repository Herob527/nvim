local M = {}

M.init = function()
	vim.g.coq_settings = {
		limits = {
			completion_auto_timeout = 0.2,
		},
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
		{
			"ms-jpq/coq.thirdparty",
			dependencies = {
				"Exafunction/codeium.vim",
				config = function()
					vim.keymap.set("i", "<C-d>", function()
						return vim.fn["codeium#Accept"]()
					end, { expr = true })
				end,
			},
			config = function()
				require("coq_3p")({
					{ src = "codeium", short_name = "COD" },
				})
			end,
		},
	},
	event = "InsertCharPre",
	config = function()
		M.init()
	end,
}
return M
