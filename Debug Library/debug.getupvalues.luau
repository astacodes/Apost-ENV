function debug.getupvalues(f)
    local u = {}
    local i = 1
    while true do
        local _, v = debug.getupvalue(f, i)
        if not _ then break end
        u[i] = v
        i = i + 1
    end
    return u
end