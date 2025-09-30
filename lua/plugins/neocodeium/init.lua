local M = {}

M.config = {
	"monkoose/neocodeium",
	event = "InsertEnter",
	cmd = { "NeoCodeium" },
	config = function()
		local neocodeium = require("neocodeium")
		neocodeium.setup()
		local is_tmux = os.getenv("TERM_PROGRAM") == "tmux"
		local is_zellij = os.getenv("ZELLIJ") ~= nil
		local accept_keybind = ""
		if is_tmux then
			accept_keybind = "<A-r>"
		elseif is_zellij then
			accept_keybind = "<C-Tab>"
		else
			accept_keybind = "<C-`>"
		end
		vim.keymap.set("i", accept_keybind, neocodeium.accept)
		vim.keymap.set("i", "<A-e>", function()
			neocodeium.cycle_or_complete()
		end)
	end,
}

return M