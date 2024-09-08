function getrunningscripts()
    local runningScripts = {}
    for _, obj in pairs(game:GetDescendants()) do
        if typeof(obj) == "Instance" and obj:IsA("ModuleScript") then
            table.insert(runningScripts, obj)
        elseif typeof(obj) == "Instance" and obj:IsA("LocalScript") then
            if obj.Enabled == true then
                table.insert(runningScripts, obj)
            end
        end
    end
    return runningScripts
end