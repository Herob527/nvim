require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the four listed parsers should always be installed)
	ensure_installed = { "c", "vim", "markdown", "markdown_inline" },
	auto_install = true,
	highlight = {
		enable = true,
	},
})
