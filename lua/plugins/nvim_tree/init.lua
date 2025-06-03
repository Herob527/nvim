local M = {}

M.init = function()
	local HEIGHT_RATIO = 0.8 -- You can change this
	local WIDTH_RATIO = 0.5 -- You can change this too

	local function on_attach(bufnr)
		local api = require("nvim-tree.api")

		local function opts(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end

		-- Default mappings. Feel free to modify or remove as you wish.
		--
		-- BEGIN_DEFAULT_ON_ATTACH
		vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
		vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
		vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
		vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
		vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
		vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
		vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
		vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
		vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
		vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
		vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
		vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
		vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command"))
		vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
		vim.keymap.set("n", "a", api.fs.create, opts("Create"))
		vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
		vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
		vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
		vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
		vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
		vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
		vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
		vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
		vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
		vim.keymap.set("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
		vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
		vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
		vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter"))
		vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
		vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
		vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
		vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
		vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
		vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
		vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
		vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
		vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
		vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
		vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
		vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
		vim.keymap.set("n", "q", api.tree.close, opts("Close"))
		vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
		vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
		vim.keymap.set("n", "s", api.node.run.system, opts("Run System"))
		vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
		vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
		vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
		vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
		vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
		vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
		vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
		vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
		-- END_DEFAULT_ON_ATTACH

		-- Mappings migrated from view.mappings.list
		--
		-- You will need to insert "your code goes here" for any mappings with a custom action_cb
		vim.keymap.set("n", "T", function()
			local node = api.tree.get_node_under_cursor()
			-- your code goes here
		end, opts("Open Tab Silently"))

		vim.keymap.set("n", "TAM", function()
			local node = api.tree.get_node_under_cursor()
			-- your code goes here
		end, opts("Tree actions"))
	end
	local tree_actions = {
		{
			name = "Create node",
			handler = require("nvim-tree.api").fs.create,
		},
		{
			name = "Remove node",
			handler = require("nvim-tree.api").fs.remove,
		},
		{
			name = "Trash node",
			handler = require("nvim-tree.api").fs.trash,
		},
		{
			name = "Rename node",
			handler = require("nvim-tree.api").fs.rename,
		},
		{
			name = "Fully rename node",
			handler = require("nvim-tree.api").fs.rename_sub,
		},
		{
			name = "Copy",
			handler = require("nvim-tree.api").fs.copy.node,
		},

		-- ... other custom actions you may want to display in the menu
	}
	require("nvim-tree").setup({
		disable_netrw = false,
		update_focused_file = { enable = true, update_root = true },
		on_attach = on_attach,
		renderer = {
			root_folder_label = false,
		},
		view = {
			width = function()
				return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
			end,

			float = {
				enable = true,
				quit_on_focus_loss = false,
				open_win_config = function()
					local screen_w = vim.opt.columns:get()
					local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
					local window_w = screen_w * WIDTH_RATIO
					local window_h = screen_h * HEIGHT_RATIO
					local window_w_int = math.floor(window_w)
					local window_h_int = math.floor(window_h)
					local center_x = (screen_w - window_w) / 2
					local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
					return {
						border = "rounded",
						relative = "editor",
						row = center_y,
						col = center_x,
						width = window_w_int,
						height = window_h_int,
					}
				end,
			},
		},
	})
	local path_sep = package.config:sub(1, 1)

	local function trim_sep(path)
		return path:gsub(path_sep .. "$", "")
	end

	local function uri_from_path(path)
		return vim.uri_from_fname(trim_sep(path))
	end

	local function is_sub_path(path, folder)
		path = trim_sep(path)
		folder = trim_sep(folder)
		if path == folder then
			return true
		else
			return path:sub(1, #folder + 1) == folder .. path_sep
		end
	end

	local function check_folders_contains(folders, path)
		-- Check if folders is nil before attempting to iterate
		if folders == nil then
			return false
		end

		-- Iterate over the folders table safely
		for _, folder in pairs(folders) do
			if folder ~= nil and folder.name ~= nil then
				if is_sub_path(path, folder.name) then
					return true
				end
			end
		end
		return false
	end

	local function match_file_operation_filter(filter, name, type)
		if filter.scheme and filter.scheme ~= "file" then
			-- we do not support uri scheme other than file
			return false
		end
		local pattern = filter.pattern
		local matches = pattern.matches

		if type ~= matches then
			return false
		end

		local regex_str = vim.fn.glob2regpat(pattern.glob)
		if vim.tbl_get(pattern, "options", "ignoreCase") then
			regex_str = "\\c" .. regex_str
		end
		return vim.regex(regex_str):match_str(name) ~= nil
	end

	local api = require("nvim-tree.api")
	api.events.subscribe(api.events.Event.NodeRenamed, function(data)
		local stat = vim.loop.fs_stat(data.new_name)
		if not stat then
			return
		end
		local type = ({ file = "file", directory = "folder" })[stat.type]
		local clients = vim.lsp.get_clients({})
		for _, client in ipairs(clients) do
			if check_folders_contains(client.workspace_folders, data.old_name) then
				local filters = vim.tbl_get(
					client.server_capabilities,
					"workspace",
					"fileOperations",
					"didRename",
					"filters"
				) or {}
				for _, filter in pairs(filters) do
					if
						match_file_operation_filter(filter, data.old_name, type)
						and match_file_operation_filter(filter, data.new_name, type)
					then
						client.notify("workspace/didRenameFiles", {
							files = {
								{ oldUri = uri_from_path(data.old_name), newUri = uri_from_path(data.new_name) },
							},
						})
					end
				end
			end
		end
	end)
end

M.config = {
	"nvim-tree/nvim-tree.lua",
	keys = { {
		"<leader>rr",
		"<cmd>:NvimTreeToggle<cr>",
		desc = "Nvim T[r]ee Toggle",
	} },
	config = function()
		M.init()
	end,
}
return M
