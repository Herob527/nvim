local luasnip = require("luasnip")
local i = luasnip.insert_node
local sn = luasnip.snippet
local t = luasnip.text_node
local s = luasnip.snippet_node
local d = luasnip.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local ts = vim.treesitter
local ts_query = ts.query

--- @param node TSNode | nil
--- @param ts_elements table<string>
--- @returns TSNode | nil
local function seek_function_root(node, ts_elements)
	if node == nil then
		return nil
	end
	local node_type = node:type()
	if vim.tbl_contains(ts_elements, node_type) or node_type == "program" then
		return node
	end

	local parent = node:parent()

	return seek_function_root(parent, ts_elements)
end

--- @param node TSNode | nil
-- TODO: This has potential to work in other langauges - just dehardcode it someday
local function get_data(node)
	local filetype = vim.bo.filetype
	local query_lang = filetype == "javascriptreact" and "jsx" or filetype
	if node == nil then
		return nil
	end
	local node_type = node:type()
	if node_type == "program" then
		return "global"
	end
	local query_str = [[
    (variable_declarator (identifier) @name)
    (function_declaration (identifier) @name)
    (method_definition (property_identifier) @name)
    (field_definition (property_identifier) @name)
]]
	local parsed_query = ts_query.parse(query_lang, query_str)
	-- print("[get_data]")
	for _, parsed_node, _ in parsed_query:iter_captures(node, 0, node:start(), node:end_()) do
		return ts.get_node_text(parsed_node, 0)
	end
end

local console = sn(
	"con",
	fmt([[ console.log("[{function_name} - {var}]",{var})]], {
		function_name = d(1, function(args)
			--- @type string
			local search = args[1][1]
			local ts_node = ts.get_node()
			local function_root = seek_function_root(
				ts_node,
				{ "function_declaration", "variable_declarator", "method_definition", "field_definition" }
			)
			vim.print(search)
			local data = function_root ~= nil and get_data(function_root) or ""
			local output = t(data)
			return s(nil, { output })
		end, { 2 }),
		var = i(2),
	}, {
		repeat_duplicates = true,
	})
)

return console
