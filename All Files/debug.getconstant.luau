function debug.getconstant(f, i)
    local c = debug.getconstants(f)
    return c[i]
end