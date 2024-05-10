local luasnip = require("luasnip")
local sn = luasnip.snippet
local fmt = require("luasnip.extras.fmt").fmt
local i = luasnip.insert_node

local vue_boilerplate = sn(
	"boil",
	fmt(
		[[<script setup lang="ts"> 
const props = defineProps<{{}}>()
{main}
</script>
<template>
{content}
</template>
  ]],
		{
			content = i(1),
			main = i(0),
		}
	)
)

return vue_boilerplate
