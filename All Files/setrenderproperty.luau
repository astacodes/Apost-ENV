function setrenderproperty(thing, prop, val)
    local success, err = pcall(function()
        thing[prop] = val
    end)
    if not success and err then 
        warn(err) 
    end
end