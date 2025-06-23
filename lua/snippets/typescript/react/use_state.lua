local luasnip = require("luasnip")
local sn = luasnip.snippet
local i = luasnip.insert_node
local t = luasnip.t
local s = luasnip.snippet_node
local d = luasnip.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

local function firstToUpper(str)
	return (str:gsub("^%l", string.upper))
end

local use_state = sn(
	"ust",
	fmt([[ const [{name},{set_name}] = useState({})]], {
		-- i(1) is at nodes[1], i(2) at nodes[2].
		name = i(1, "value"),
		set_name = d(2, function(args)
			local state_name = firstToUpper(args[1][1])
			return s(nil, { t("set" .. state_name) })
		end, { 1 }),
		i(0),
	})
)

return use_state
