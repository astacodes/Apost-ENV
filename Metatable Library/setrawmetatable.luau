function setrawmetatable(object, newmetatbl)
    if type(object) ~= "table" and type(object) ~= "userdata" then
        warn("expected table or userdata", 2)
    end
    if type(newmetatbl) ~= "table" and newmt ~= nil then
        warn("new metatable must be a table or nil", 2)
    end
    local raw_mt = debug.getmetatable(object)
        if raw_mt and raw_mt.__metatable then
        local old_metatable = raw_mt.__metatable
        raw_mt.__metatable = nil  
                local success, err = pcall(setmetatable, object, newmetatbl)
                raw_mt.__metatable = old_metatable
                if not success then
			warn("failed to set metatable : " .. tostring(err), 2)
        end
        return true  
    end
        setmetatable(object, newmetatbl)
    return true
end