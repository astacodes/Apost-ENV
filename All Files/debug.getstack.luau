function debug.getstack(l, i)
    local s = {}
    local j = 1
    while true do
        local n, v = debug.getlocal(l + 1, j)
        if not n then break end
        s[j] = v
        j = j + 1
    end
    return i and s[i] or s
end