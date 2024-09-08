function debug.setmetatable(tableorud, newmt)
    local current_metatable = debug.getmetatable(tableorud)
        if current_metatable and current_metatable.__metatable then
		warn("Metatable is locked and cannot be changed.")
    end
    local success, result = pcall(setmetatable, tableorud, newmt)
        if not success then
		warn("Failed to set metatable: " .. tostring(result))
    end
    return newmt
end