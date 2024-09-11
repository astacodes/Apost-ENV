function getthreadidentity()
    return identity
end

function getidentity()
    return getthreadidentity()
end

function getthreadcontext()
    return getthreadidentity()
end
