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

local path = vim.fn.stdpath("data") .. "/projects"

local function get_project()
	local root_files = { ".git" }

	--- @type string?
	local project_root = vim.fs.root(0, root_files)
	if project_root == nil then
		vim.print("Project root works only with .git. Init git repo first")
		return nil, nil
	end
	--- @type string
	local project_name = project_root:match("[^/]+$")

	--- @type string
	local project_path = path .. "/" .. project_name .. ".json"

	return project_name, project_path
end

-- Command to create project settings used by nvim
vim.api.nvim_create_user_command("CreateProjectSettings", function(opts)
	local project_name, project_path = get_project()
	if project_name == nil or project_path == nil then
		return
	end

	if vim.fn.isdirectory(path) == 0 then
		vim.fn.mkdir(path, "p")
	end

	if vim.fn.filereadable(project_path) == 1 then
		vim.print("Project " .. project_name .. " already exists")
		return
	end
	vim.fn.writefile({ "project_name = " .. project_name }, project_path)
end, {})

vim.api.nvim_create_user_command("AttachI18nConfig", function(opts)
	local project_name, project_path = get_project()
	vim.print(opts)
	local path, language = opts.fargs[1], opts.fargs[2]
end)

-- Command to extract selected text into picked i18n file
vim.api.nvim_create_user_command("ExtractToI18n", function(opts) end, {})
