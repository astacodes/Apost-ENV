-- This function requires a dependency found in the Dependencies.luau file! It will not function properly without them

function setthreadidentity(id)
    identity = id
end

function setidentity(id)
    return setthreadidentity(id)
end

function setthreadcontext(id)
    return setthreadidentity(id)
end