vim.filetype.add({ extension = { mdx = "mdx" } })

require("plugins_entry")

require("key_bindings")
require("opts")

vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		if vim.bo.filetype == "tf" then
			vim.bo.filetype = "terraform"
		end
	end,
})

vim.filetype.add({
	filename = {
		[".nvmrc"] = "nvmrc",
	},
})

vim.lsp.commands["editor.action.showReferences"] = function(command, ctx)
	local locations = command.arguments[3]
	local client = vim.lsp.get_client_by_id(ctx.client_id)
	if locations and #locations > 0 then
		if client == nil then
			return
		end

		local items = vim.lsp.util.locations_to_items(locations, client.offset_encoding)
		vim.fn.setloclist(0, {}, " ", { title = "References", items = items, context = ctx })
		vim.api.nvim_command("lopen")
	end
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.gitlab-ci*.{yml,yaml}",
	callback = function()
		vim.bo.filetype = "yaml.gitlab"
	end,
})
if vim.g.neovide then
	vim.g.neovide_cursor_animation_length = 0
	vim.o.guifont = "Source Code Pro:h10" -- text below applies for VimScript
end

local path = vim.fn.stdpath("data") .. "/projects.json"

-- Command to create project settings used by nvim
vim.api.nvim_create_user_command("CreateProjectSettings", function(opts)
	if vim.fn.filereadable(path) == 0 then
		vim.fn.writefile({ "{}" }, path)
	end
	local project_root_file = { "package.json" }
	local project_root = vim.fs.root(0, project_root_file)

	if project_root == nil then
		return
	end

	local current_data = vim.fn.json_decode(vim.fn.readfile(path))
	if current_data[project_root] ~= nil then
		vim.print("Project already exists")
		return
	end
	local data = {
		[project_root] = vim.empty_dict(),
	}
	vim.tbl_extend("force", current_data, data)
	local json_data = vim.fn.json_encode(data)
	vim.fn.writefile({ json_data }, path)
end, {})

vim.api.nvim_create_user_command("AttachI18nConfig", function(opts)
	if not opts.args then
		print("No arguments provided for AttachI18nConfig")
		return
	end

	local args = vim.split(vim.trim(opts.args), ",")
	if #args < 4 then
		print("Not enough arguments provided (directory, mainLocale, translationFunction, fileType)")
		return
	end

	local directory = args[1]
	local mainLocale = args[2]
	local translationFunction = args[3]
	local fileType = args[4]

	local project_root_file = { "package.json" }
	local project_root = vim.fs.root(0, project_root_file)

	if project_root == nil then
		return
	end

	local current_data = vim.fn.json_decode(vim.fn.readfile(path))
	if current_data[project_root]["translations"] ~= nil then
		print("Translations already attached")
		return
	end

	local translations_data = {
		directory = directory,
		mainLocale = mainLocale,
		fileType = fileType,
		translationFunction = translationFunction,
	}
	current_data[project_root] =
		vim.tbl_extend("force", current_data[project_root], { translations = translations_data })

	local json_data = vim.fn.json_encode(current_data)
	vim.fn.writefile({ json_data }, path)

	-- Create a dummy locale file for the main locale
	local dummy_file_path = project_root .. "/" .. directory .. "/" .. mainLocale .. "." .. fileType
	if not vim.fn.filereadable(dummy_file_path) then
		vim.fn.writefile({}, dummy_file_path)
	end
end, {})
-- Command to extract selected text into picked i18n file
vim.api.nvim_create_user_command("ExtractToI18n", function(opts)
	if not opts.range then
		print("No range provided for ExtractToI18n")
		return
	end
	-- Get the start and end positions of the selection
	local _, start_line, start_col, _ = unpack(vim.fn.getpos("'<"))
	local _, end_line, end_col, _ = unpack(vim.fn.getpos("'>"))
	-- Create a range for the selected lines
	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
	local key = opts.args

	-- Extract the selected text
	local selected_text = ""
	if start_line == end_line then
		-- Single line selection
		selected_text = lines[1]:sub(start_col, end_col)
	else
		-- Multi-line selection
		table.insert(selected_text, lines[1]:sub(start_col))
		for i = start_line + 1, end_line - 1 do
			table.insert(selected_text, lines[i - start_line + 1])
		end
		table.insert(selected_text, lines[#lines]:sub(1, end_col))
		selected_text = table.concat(selected_text, "\n")
	end

	local project_root_file = { "package.json" }
	local project_root = vim.fs.root(0, project_root_file)

	if project_root == nil then
		return
	end

	local config_data = vim.fn.json_decode(vim.fn.readfile(path))
	if not config_data[project_root]["translations"] then
		print("No translations configured. Run :AttachI18nConfig with appropriate arguments")
		return
	end

	local translation_data = config_data[project_root]["translations"]
	local translations_dir = project_root .. "/" .. translation_data.directory

	local captures = vim.treesitter.get_captures_at_pos(0, start_line - 1, start_col - 1)
	local any_jsx = vim.iter(captures):any(function(capture)
		return capture.capture:match("jsx")
	end)
	local translation_function = translation_data.translationFunction .. '("' .. key .. '")'

	local inside_jsx = any_jsx and "{" .. translation_function .. "}" or translation_function

	local is_any_character_utf_8 = vim.iter(vim.split(selected_text, "")):any(function(char)
		return string.byte(char) > 127
	end)
	-- Replace the selected text with the translation function
	vim.api.nvim_buf_set_text(
		0,
		start_line - 1,
		start_col - 1,
		end_line - 1,
		is_any_character_utf_8 and end_col - 1 or end_col,
		{ inside_jsx }
	)

	if vim.fn.isdirectory(translations_dir) == 0 then
		vim.fn.mkdir(translations_dir, "p")
	end
	local file_path = translations_dir .. "/" .. translation_data.mainLocale .. "." .. translation_data.fileType
	if vim.fn.filereadable(file_path) == 0 then
		vim.fn.writefile({ "{}" }, file_path)
	end
	local file_content = vim.fn.readfile(file_path)
	local current_data = vim.fn.json_decode(file_content)
	if current_data[key] then
		vim.notify("Translation '" .. key .. "' already exists")
		return
	end

	current_data[key] = selected_text:gsub('"', ""):gsub("^%s+", ""):gsub("%s+$", "")
	local encoded_json = vim.fn.json_encode(current_data)

	vim.fn.writefile({ encoded_json }, file_path)
end, { range = true, nargs = "*" })

vim.api.nvim_create_user_command("ExtractSvgToFile", function(opts)
	local args = vim.split(vim.trim(opts.args):gsub("['\"]", ""), ",")
	local component_name = args[1]
	local output_dir = args[2]

	local project_root_file = { "package.json" }
	local project_root = vim.fs.root(0, project_root_file)

	local svg_path = project_root .. "/" .. output_dir

	local _, start_line, start_col, _ = unpack(vim.fn.getpos("'<"))
	local _, end_line, end_col, _ = unpack(vim.fn.getpos("'>"))

	--- @type string[]
	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
	local joined_lines = table.concat(lines, " "):gsub("{", '"'):gsub("}", '"')
	local className = joined_lines:match('className="([^"]+)"')
	local content = { "<" .. component_name .. " " .. (className and "className='" .. className .. "'" or "") .. " />" }
	joined_lines = joined_lines:gsub('className="([^"]+)"', "")

	vim.print(end_col, content[1]:len())

	vim.api.nvim_buf_set_text(0, start_line - 1, start_col - 1, end_line - 1, end_col, content)
	local import_text = "import " .. component_name .. " from '" .. output_dir .. "'"
	vim.api.nvim_buf_set_lines(0, 0, 0, false, { import_text })
	if vim.fn.filereadable(svg_path) == 0 then
		vim.fn.writefile({ joined_lines }, svg_path)
	end

	-- Extract the selected text
end, { range = true })
