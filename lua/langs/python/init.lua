local M = {}

M.treesitter = { "python" }

M.lspconfig = {
	{ lsp = "pyright" },
}

M.mason = {}

M.mason.lspconfig = {
	"pyright",
}

M.mason.null_ls = {
	"black",
	"ruff",
}

M.null_ls = {
	formatting = { { program = "black" }, { program = "ruff" } },
	diagnostics = { { program = "ruff" } },
}

M.dap = {}

M.dap.mason = { "python" }

M.dap.adapter = function(cb, config)
	if config.request == "attach" then
		---@diagnostic disable-next-line: undefined-field
		local port = (config.connect or config).port
		---@diagnostic disable-next-line: undefined-field
		local host = (config.connect or config).host or "127.0.0.1"
		cb({
			type = "server",
			port = assert(port, "`connect.port` is required for a python `attach` configuration"),
			host = host,
			options = {
				source_filetype = "python",
			},
		})
	else
		cb({
			type = "executable",
			command = "python",
			args = { "-m", "debugpy.adapter" },
			options = {
				source_filetype = "python",
			},
		})
	end
end

M.dap.config = {
	{
		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = "launch",
		name = "Launch file",
		program = "${file}", -- This configuration will launch the current file if used.
	},
}

return M
