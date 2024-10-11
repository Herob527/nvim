local luasnip = require("luasnip")

local flex_center = require("snippets.css.css.flex_center")
local tailwind_like_media_queries = require("snippets.css.css.tailwind_like_queries")
local button_reset = require("snippets.css.css.button_reset")

local css = {
	flex_center,
	button_reset,
}

for _, value in ipairs(tailwind_like_media_queries) do
	table.insert(css, value)
end

luasnip.add_snippets("css", css)
