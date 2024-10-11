local luasnip = require("luasnip")
local sn = luasnip.snippet
local fmt = require("luasnip.extras.fmt").fmt

local construction = [[
background: transparent;
border: none;
cursor: pointer;
]]

local snippet = sn({
	trig = "btn-reset",
	description = "Reset button style",
}, fmt(construction, {}))

return snippet
