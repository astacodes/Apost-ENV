function getgc()
    local function CheckObject(obj, visited, results)
        if visited[obj] then return end
        visited[obj] = true
        
        if type(obj) == "table" or type(obj) == "function" then
            table.insert(results, obj)
            if type(obj) == "table" then
                for _, v in pairs(obj) do
                    CheckObject(v, visited, results)
                end
            end
        end
    end

    local visited, results = {}, {}
    CheckObject(getgenv(), visited, results)
    
    return results
end