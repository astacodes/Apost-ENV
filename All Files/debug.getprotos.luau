function debug.getprotos(f)
    local protos = {}
    local i = 1
        local function get_prototypes(func)
        local index = 1
        while true do
            local name, func = debug.getupvalue(func, index)
            if not name then break end
            if type(func) == "function" then
                table.insert(protos, func)
                get_prototypes(func) 
            end
            index = index + 1
        end
    end
    get_prototypes(f)
    
    return protos
end