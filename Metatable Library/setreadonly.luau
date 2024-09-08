function setreadonly(tbl, readOnly)
    if readOnly then
        saved_data.ReadOnly[tbl] = true
        local clone = table.clone(tbl)
        saved_data.OriginalTables[clone] = tbl
        return saved_data.Luau_setmetatable(clone, {
            __index = tbl,
            __newindex = function(_, key, value)
                warn("attempt to modify a readonly table")
            end
        })
    else
        return tbl 
    end
end