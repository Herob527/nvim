local langs_table = {
	lua = require("langs.lua.init"),
	rust = require("langs.rust.init"),
	js = require("langs.javascript.init"),
	css = require("langs.css.init"),
	html = require("langs.html.init"),
	tailwindcss = require("langs.tailwindcss.init"),
	python = require("langs.python.init"),
	json = require("langs.json.init"),
	yaml = require("langs.yaml.init"),
	markdown = require("langs.markdown.init"),
	graphql = require("langs.graphql.init"),
	vue = require("langs.vue.init"),
	sh = require("langs.sh.init"),
	dockerfile = require("langs.dockerfile.init"),
	astro = require("langs.astro.init"),
	ruby = require("langs.ruby.init"),
}
return langs_table
