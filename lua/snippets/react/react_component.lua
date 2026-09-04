local luasnip = require("luasnip")
local sn = luasnip.snippet
local i = luasnip.insert_node
local t = luasnip.text_node
local s = luasnip.snippet_node
local d = luasnip.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

local function get_name()
	return vim.fn.expand("%:t:r")
end

local function make_export(args)
	return s(nil, t("export default " .. args[1][1]))
end

local ts_fcb = sn(
	"FCB",
	fmt(
		[[
const {name} = () => {{
  {}
}};

{export_method}
]],
		{
			name = d(1, function()
				return s(nil, t(get_name()))
			end),
			export_method = d(2, make_export, { 1 }),
			i(0),
		},
		{ repeat_duplicates = true }
	)
)

local ts_fcb_plus = sn(
	"FCB+",
	fmt(
		[[
interface Props {{}}

const {name} = ({{}}: Props) => {{
  {}
}};

{export_method}
]],
		{
			name = d(1, function()
				return s(nil, t(get_name()))
			end),
			export_method = d(2, make_export, { 1 }),
			i(0),
		},
		{ repeat_duplicates = true }
	)
)

local js_fcb = sn(
	"FCB",
	fmt(
		[[
const {name} = () => {{
  {}
}};

{export_method}
]],
		{
			name = d(1, function()
				return s(nil, t(get_name()))
			end),
			export_method = d(2, make_export, { 1 }),
			i(0),
		},
		{ repeat_duplicates = true }
	)
)

local js_fcb_plus = sn(
	"FCB+",
	fmt(
		[[
const {name} = ({{}}) => {{
  {}
}};

{export_method}
]],
		{
			name = d(1, function()
				return s(nil, t(get_name()))
			end),
			export_method = d(2, make_export, { 1 }),
			i(0),
		},
		{ repeat_duplicates = true }
	)
)

return {
	ts = { ts_fcb, ts_fcb_plus },
	js = { js_fcb, js_fcb_plus },
}
