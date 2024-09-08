function debug.getupvalue(f, i)
    local _, v = debug.getupvalue(f, i)
    return v
end