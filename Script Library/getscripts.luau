
function getscripts()
    local scripts = {}
    for _, scriptt in game:GetDescendants() do
        if scriptt:isA("LocalScript") or scriptt:isA("ModuleScript") then
            table.insert(scripts, scriptt)
        end
    end
    return scripts
end