identity = 3

function getthreadidentity()
    return identity
end

function getidentity()
    return getthreadidentity()
end

function getthreadcontext()
    return getthreadidentity()
end

function setthreadidentity(id)
    identity = id
end

function setidentity(id)
    return setthreadidentity(id)
end

function setthreadcontext(id)
    return setthreadidentity(id)
end
