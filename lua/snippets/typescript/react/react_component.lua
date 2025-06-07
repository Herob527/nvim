local luasnip = require("luasnip")
local sn = luasnip.snippet
local i = luasnip.insert_node
local t = luasnip.text_node
local s = luasnip.snippet_node
local d = luasnip.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

local react_boilerplate = sn(
	"FunComBoi",
	fmt(
		[[
import React from 'react';

interface Props {{

}}

const {name} = ({{}}: Props) => {{
  {}
}};

{export_method}
]],
		{
			name = d(1, function()
				-- Get name of current file
				return s(nil, t(vim.fn.expand("%:r:t")))
			end),
			export_method = d(2, function(args)
				local component_name = args[1][1]
				return s(nil, t("export default " .. component_name))
			end, { 1 }),
			i(0),
		},
		{
			repeat_duplicates = true,
		}
	)
)

return react_boilerplate
