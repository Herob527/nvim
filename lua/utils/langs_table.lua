local M = {}

M.langs_iterator = function()
	local langs_codes = {
		"lua",
		"rust",
		"javascript",
		"css",
		"html",
		"tailwindcss",
		"python",
		"json",
		"yaml",
		"markdown",
		"graphql",
		"vue",
		"sh",
		"dockerfile",
		"astro",
		"prose",
		"terraform",
		"haskell",
		"cs",
	}

	local index = 1
	return function()
		while true do
			if index > #langs_codes then
				return nil
			end
			local lang = langs_codes[index]
			index = index + 1
			return { lang, require("langs." .. lang .. ".init") }
		end
	end
end

return M
