function getrawmetatable(object)
    if type(object) ~= "table" and type(object) ~= "userdata" then
        warn("expected tbl or userdata", 2)
    end
    local raw_mt = debug.getmetatable(object)
    if raw_mt and raw_mt.__metatable then
        raw_mt.__metatable = nil 
        local result_mt = debug.getmetatable(object)
        raw_mt.__metatable = "Locked!" 
        return result_mt
    end
    
    return raw_mt
end