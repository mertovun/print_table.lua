local print_table = {}

local function type_to_string(value, visited)
    local valueType = type(value)
    if valueType == "string" then
        return string.format("%q", value)
    elseif valueType == "nil" or valueType == "number" or valueType == "boolean" then
        return tostring(value)
    elseif valueType == "function" then
        return "<function>"
    elseif valueType == "userdata" then
        return "<userdata>"
    elseif valueType == "thread" then
        return "<thread>"
    elseif valueType == "table" then
        -- Check if the table has been visited and return its path if so
        if visited[value] then
            return "<circular ref: " .. visited[value] .. ">"
        else
            return nil -- To be handled separately
        end
    else
        return "<unknown>"
    end
end

local function traverse_table(tbl, callback, level, visited, path)
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

setmetatable(print_table, {
  __call = function(self, tbl)
      traverse_table(tbl, print_kv)
  end
})

return print_table