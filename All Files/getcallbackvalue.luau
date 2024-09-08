function getcallbackvalue(object, methodName, ...)
    if object and type(object[methodName]) == "function" then
        return object[methodName]
    end
    local args = {...}
    return args[1]
end