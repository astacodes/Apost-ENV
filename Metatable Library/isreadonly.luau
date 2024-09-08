function isreadonly(tbl)
    return saved_data.ReadOnly[tbl] or table.isfrozen(tbl) or false
end