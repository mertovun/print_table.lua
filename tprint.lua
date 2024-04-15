local tprint = {}

local function traverse_table(tbl, callback, level, visited)
	level = level or 0
	visited = visited or {}

	if visited[tbl] then
			callback(level, "<circular ref>", nil)
			return
	end

	visited[tbl] = true

	for key, value in pairs(tbl) do
			callback(level, key, value)
			if type(value) == "table" then
					traverse_table(value, callback, level + 1, visited)
			end
	end
end

local function print_kv(level, key, value)
	local indent = string.rep("  ", level)
	if type(value) == "table" then
			print(indent .. "Key " .. key .. ":")
	else
			print(indent .. "Key " .. key .. ": " .. tostring(value))
	end
end

setmetatable(tprint, {
  __call = function(self, tbl)
      traverse_table(tbl, print_kv)
  end
})

return tprint