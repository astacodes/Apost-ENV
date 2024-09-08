function hookmetamethod(obj, method, rep)
    local mt = getrawmetatable(obj)
    local old = mt[method]
    
    setreadonly(mt, false)
    mt[method] = rep
    setreadonly(mt, true)
    
    return old
end