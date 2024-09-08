-- This function requires a dependency found in the Dependencies.luau file! It will not function properly without them

function cleardrawcache()
    for _, v in pairs(Drawings) do
        v:Remove()
    end
    table.clear(Drawings)
end