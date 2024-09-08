function getgenv(): { [string]: any }
    return getfenv(2)
end

-- This may not work depending on your executor's setup