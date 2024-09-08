function getloadedmodules()
    local moduleScripts = {}
    for _, obj in pairs(game:GetDescendants()) do
        if typeof(obj) == "Instance" and obj:IsA("ModuleScript") then 
            table.insert(moduleScripts, obj) 
        end
    end
    return moduleScripts
end