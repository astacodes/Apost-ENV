function cloneref(reference)
    if game:FindFirstChild(reference.Name) or reference.Parent == game then
        return reference
    else
        local class = reference.ClassName
        local cloned = Instance.new(class)
        local mt = {
            __index = reference,
            __newindex = function(t, k, v)
                if k == "Name" then
                    reference.Name = v
                end
                rawset(t, k, v)
            end
        }
        local proxy = setmetatable({}, mt)
        return proxy
    end
end