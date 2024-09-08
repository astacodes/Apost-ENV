function gethui()
    local success, hui = pcall(function()
        return game:GetService("CoreGui")["RobloxGui"]
    end)
    if success then
        return hui
    else
        warn("Failed to get RobloxGui")
        return nil
    end
end