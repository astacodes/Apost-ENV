cache = {}

function cache.iscached(thing)
    if not thing.Parent then
        return cache[thing] ~= 'REMOVE'
    else
        return false
    end
end

function cache.invalidate(thing)
    cache[thing] = 'REMOVE'
    thing.Parent = nil
end

function cache.replace(a, b)
    if cache[a] then
        cache[a] = b
    end
end
