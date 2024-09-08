function debug.setconstant(f, i, v)
    local c = debug.getconstants(f)
    local tmp = function() return v end
    local nf = load(string.dump(tmp))
    debug.setupvalue(nf, 1, v)
    for j = 1, #c do
        if j == i then
            debug.setupvalue(f, j, v)
        else
            debug.setupvalue(f, j, c[j])
        end
    end
end