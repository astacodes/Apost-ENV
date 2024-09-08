function debug.getproto(f, index)
    local function find_prototype(func, idx)
        local count = 1
        local i = 1
        while true do
            local name, upvalue = debug.getupvalue(func, i)
            if not name then break end
            if type(upvalue) == "function" then
                if count == idx then
                    return upvalue
                end
                count = count + 1
            end
            i = i + 1
        end
        return nil
    end
    
    return find_prototype(f, index)
end