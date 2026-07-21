local luasnip = require("luasnip")
local sn = luasnip.snippet
local i = luasnip.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local format = [[
---
interface Props {{}}
---
<{entry}
]]

local snippet = sn(
	"AstroComBoi",
	fmt(format, {

		entry = i(0),
	})
)

return snippet
