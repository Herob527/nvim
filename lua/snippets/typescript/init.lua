local luasnip = require("luasnip")

local react_component = require("snippets.react.react_component")
local use_state = require("snippets.typescript.react.use_state")

local react_snippets = {}
for _, snippet in ipairs(react_component.ts) do
	table.insert(react_snippets, snippet)
end
table.insert(react_snippets, use_state)

local ts_snippets = {}
for _, snippet in ipairs(react_component.ts) do
	table.insert(ts_snippets, snippet)
end
table.insert(ts_snippets, use_state)

luasnip.add_snippets("typescriptreact", react_snippets)
luasnip.add_snippets("typescript", ts_snippets)

for _, file in
	ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/snippets/console_snippets", [[v:val =~ '\.lua$']]))
do
	local filename = file:gsub("%.lua$", "")
	local snippet = require("snippets.console_snippets." .. filename)
	luasnip.add_snippets(filename, { snippet })
end
