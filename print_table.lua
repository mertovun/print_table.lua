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
    path = path or "root"

    if visited[tbl] then
        callback(level, path, "<circular ref>", nil)
        return
    end

    visited[tbl] = path

    for key, value in pairs(tbl) do
        local keyPath = path .. "." .. key
        local valueStr = type_to_string(value, visited)
        if valueStr then
            callback(level, key, valueStr)
        else
            -- It's a table; print its key, and the table content will be handled by recursion
            print(string.rep("  ", level) .. key .. ":")
            traverse_table(value, callback, level + 1, visited, keyPath)
        end
    end
end

local function print_kv(level, key, value)
    local indent = string.rep("  ", level)
    print(indent .. key .. ": " .. value)
end

setmetatable(print_table, {
  __call = function(self, tbl)
      traverse_table(tbl, print_kv)
  end
})

return print_table
