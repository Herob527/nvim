local M = {}

M.OPEN_AI_ENDPOINT = "http://localhost:1234/v1"

--- @param url string | nil
M.is_operational = function(url)
	local response = vim.fn.systemlist({
		"curl",
		"-s", -- silent mode
		"-w",
		"%{http_code}", -- show only status code
		"-o",
		"/dev/null", -- suppress output
		url or M.OPEN_AI_ENDPOINT,
	})[1]
	local is_running = tonumber(response) == 200

	return is_running
end

return M
