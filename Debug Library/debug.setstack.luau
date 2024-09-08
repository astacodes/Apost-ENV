function debug.setstack(l, i, v)
    local n = debug.getlocal(l + 1, i)
    if n then
        debug.setlocal(l + 1, i, v)
    end
end