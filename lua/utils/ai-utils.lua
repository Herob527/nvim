local M = {}

M.OPEN_AI_ENDPOINT = "http://localhost:11434"

M.TESTED_MODEL_ID = "deepseek-r1:1.5b"

local notified = false
--- @param url string | nil
M.is_operational = function(url)
	local response = vim.fn.systemlist({
		"curl",
		"-X",
		"GET",
		"-s", -- silent mode
		"-w",
		"%{http_code}", -- show only status code
		"-o",
		"/dev/null", -- suppress output
		url or M.OPEN_AI_ENDPOINT .. "/models",
	})[1]
	local is_running = tonumber(response) == 200
	if not notified and not is_running then
		vim.notify(
			"AI service responded with status " .. tonumber(response) .. ". AI plugins will be disabled.",
			vim.log.levels.INFO
		)
		notified = true
	end

	return is_running
end

return M
