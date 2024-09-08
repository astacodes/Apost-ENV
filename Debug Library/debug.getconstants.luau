function debug.getconstants(f)
    local c = {}
    local i = 1
    while true do
        local k = debug.getconstant(f, i)
        if not k then break end
        c[i] = k
        i = i + 1
    end
    return c
end