local M = {}

M.init = function()
	local langs_table = require("utils.langs_table")
	local langs = langs_table.langs_iterator()
	local project_marker = { "package.json", "pyproject.toml", ".git" }
	local project_root = vim.fs.root(0, project_marker)
	local langs_data = vim.iter(langs)
		:map(function(data)
			local lang = data[1]
			local content = data[2]
			if content.conform == nil or vim.tbl_isempty(content.conform) then
				return nil
			-- TODO: Make this flexible allowing more formatters follow this
			elseif project_root ~= nil and type(content.conform[1]) == "table" then
				local has_requires = vim.iter(content.conform[1].requires)
					:map(function(item)
						return project_root .. "/" .. item
					end)
					:any(function(item)
						return vim.fn.filereadable(item) == 1
					end)

				if has_requires then
					return { [lang] = { content.conform[1].name } }
				else
					return nil
				end
			else
				-- vim.print(content.conform)
				return { [lang] = content.conform }
			end
		end)
		:filter(function(data)
			return data ~= nil
		end)
		:totable()

	local formatters = {}
	local options = {}

	for k in pairs(langs_data) do
		formatters = vim.tbl_extend("force", formatters, langs_data[k])
		local current_lang = vim.tbl_keys(langs_data[k])[1]
		local lang_data = langs_table.get_lang_data(current_lang)
		if lang_data.conform_options ~= nil then
			options = vim.tbl_extend("force", options, langs_table.get_lang_data(current_lang).conform_options)
		end
		if
			lang_data.filetypes ~= nil
			and vim.iter(lang_data.filetypes):any(function(item)
				return item == current_lang
			end)
		then
			for key, v in pairs(lang_data.filetypes) do
				formatters[v] = vim.tbl_values(langs_data[k])[1]
				-- options = vim.tbl_extend("force", options, lang_data.conform)
			end
		end
	end

	local xml_langs = { "xml", "svg" }

	local tailwind_langs = { "html", "javascriptreact", "typescriptreact" }

	for _, lang in ipairs(tailwind_langs) do
		table.insert(formatters[lang] or {}, "rustywind")
	end

	for _, lang in ipairs(xml_langs) do
		formatters[lang] = { "xmlformatter" }
	end

	require("conform").setup({
		format_after_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		formatters_by_ft = formatters,
		formatters = options,
	})
end

M.config = {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	config = function()
		M.init()
	end,
	dependencies = {
		{
			"zapling/mason-conform.nvim",
			event = "VeryLazy",
			config = function()
				require("mason-conform").setup()
			end,
		},
	},
}

return M
