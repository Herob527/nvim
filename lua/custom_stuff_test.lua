function string:endswith(suffix)
	return self:sub(-#suffix) == suffix
end

local function lines(str)
	local result = {}
	for line in str:gmatch("[^\n]+") do
		table.insert(result, line)
	end
	return result
end

local function split_args(str)
	local result = {}
	for line in str:gmatch("[^ ]+") do
		table.insert(result, line)
	end
	return result
end

local function create_page(name)
	if name == nil or name == "" then
		error("No name provided")
		return
	end
	local cwd = vim.fn.getcwd()
	local page_path = cwd .. "/src/pages/" .. name
	if not page_path:endswith(".astro") then
		page_path = page_path .. ".astro"
	end

	local dummy_content = [[
---
interface Props {

}
---]]
	vim.fn.delete(page_path)
	vim.fn.writefile(lines(dummy_content), page_path, "a")
end

vim.api.nvim_create_user_command("AddPage", function(opts)
	local cwd = vim.fn.getcwd()
	local astro_config_path = cwd .. "/astro.config.mjs"
	local args = split_args(opts.args)
	if #args > 1 then
		error("Too many arguments. This function accepts one")
		return
	end

	if vim.fn.filereadable(astro_config_path) == 0 then
		return
	end
	print(args[1])
	if #args == 1 and args[1] ~= "" then
		create_page(args[1])
	else
		vim.ui.input({ prompt = "Page name: " }, function(page_name)
			create_page(page_name)
		end)
	end
end, { nargs = "?" })

vim.keymap.set("n", "<leader>ap", "<cmd>AddPage<cr>")
