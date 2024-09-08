-- This function requires a dependency found in the Dependencies.luau file! It will not function properly without them

function getthreadidentity()
    return identity
end

function getidentity()
    return getthreadidentity()
end

function getthreadcontext()
    return getthreadidentity()
end