function debug.setupvalue(f, i, v)
    local nf = load(string.dump(f))
    local j = 1
    while true do
        local n = debug.getupvalue(nf, j)
        if not n then break end
        if j == i then
            debug.setupvalue(nf, j, v)
        else
            debug.setupvalue(nf, j, debug.getupvalue(f, j))
        end
        j = j + 1
    end
    return nf
end