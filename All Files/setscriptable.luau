function setscriptable(instance, property, scriptable)
    local className = instance.ClassName
        if not scriptableProperties[className] then
        scriptableProperties[className] = {}
    end
        local wasScriptable = scriptableProperties[className][property] or false
        scriptableProperties[className][property] = scriptable
        if scriptable then
        local mt = getmetatable(instance) or {}
        mt.__index = function(t, key)
            if key == property then
                return scriptable
            end
            return rawget(t, key)
        end
        mt.__newindex = function(t, key, value)
            if key == property then
                rawset(t, key, value)
            else
                rawset(t, key, value)
            end
        end
        setmetatable(instance, mt)
    end
    return wasScriptable
end