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
