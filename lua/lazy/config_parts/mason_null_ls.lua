local mason = {
	"williamboman/mason.nvim",
	event = "VeryLazy",
	config = function()
		require("mason").setup()
	end,
}

local function inArray(arr, element) -- function to check if something is in an array
	for _, value in ipairs(arr) do -- ipairs is the recommended iterator for looping through arrays
		if value == element then
			return true
		end
	end
	return false -- if no element was found, return false
end

local mason_null_ls = {
	"jay-babu/mason-null-ls.nvim",

	event = "VeryLazy",
	config = function()
		local langs_table = require("utils.langs_table")

		local ensure_installed = {}
		for _, val in pairs(langs_table) do
			for _, null_ls_program in pairs(val.mason.null_ls) do
				if not inArray(ensure_installed, null_ls_program) then
					table.insert(ensure_installed, null_ls_program)
				end
			end
		end
		require("mason-null-ls").setup({ ensure_installed = ensure_installed })
	end,
	dependencies = { mason },
}

local null_ls_iterator = function()
	local null_ls = require("null-ls")
	local langs_table = require("utils.langs_table")

	local languages = {}

	for lang, data in pairs(langs_table) do
		table.insert(languages, { language = lang, data = data })
	end

	local idx = 1

	return function()
		local current_data = languages[idx].data.null_ls
		local lang_sources = {}
		if idx == #languages then
			return nil
		end
		for type, null_ls_data in pairs(current_data) do
			for _, val in pairs(null_ls_data) do
				local null_ls_builtin = null_ls.builtins[type][val.program]
				table.insert(lang_sources, val.with and null_ls_builtin.with(val.with) or null_ls_builtin)
			end
		end
		idx = idx + 1
		return idx, lang_sources
	end
end

local null_ls = {
	"nvimtools/none-ls.nvim",

	event = "VeryLazy",
	config = function()
		-- Languages setup
		local null_ls = require("null-ls")

		local sources = {
			null_ls.builtins.completion.luasnip,
		}
		local iterator = null_ls_iterator()
		for _, lang_sources in iterator do
			for _, source in pairs(lang_sources) do
				table.insert(sources, source)
			end
		end

		null_ls.setup({
			sources = sources,
			on_attach = require("lsp-format").on_attach,
		})
	end,
	dependencies = {
		mason_null_ls,
		{
			"lukas-reineke/lsp-format.nvim",
		},
	},
}

return null_ls
