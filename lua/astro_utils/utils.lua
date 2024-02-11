local M = {}

--- @param string string
--- @param suffix string
M.endswith = function(string, suffix)
	return string:sub(-#suffix) == suffix
end

--- @param str string
--- @return string[]
M.lines = function(str)
	local result = {}
	for line in str:gmatch("[^\n]+") do
		table.insert(result, line)
	end
	return result
end

--- @param str string
--- @return string[]
M.split_args = function(str)
	local result = {}
	for line in str:gmatch("[^ ]+") do
		table.insert(result, line)
	end
	return result
end

return M
