-- Note: I did not make this one, credits to whoever did

function debug.getmetatable(tableorud)
    local result = getmetatable(tableorud)

    if result == nil then -- No meta
        return
    end

    if type(result) == "table" and pcall(setmetatable, tableorud, result) then
        return result
    end

    local real_metamethods = {}

    xpcall(function()
        return tableorud._
    end, function()
        real_metamethods.__index = debug.info(2, "f")
    end)

    xpcall(function()
        tableorud._ = tableorud
    end, function()
        real_metamethods.__newindex = debug.info(2, "f")
    end)

    xpcall(function()
        return tableorud:___() 
    end, function()
        real_metamethods.__namecall = debug.info(2, "f")
    end)

    xpcall(function()
        tableorud()
    end, function()
        real_metamethods.__call = debug.info(2, "f")
    end)

    xpcall(function()
        for _ in tableorud do
        end
    end, function()
        real_metamethods.__iter = debug.info(2, "f")
    end)

    xpcall(function()
        return #tableorud
    end, function()
        real_metamethods.__len = debug.info(2, "f")
    end)

    local type_check_semibypass = {}

    xpcall(function()
        return tableorud == type_check_semibypass
    end, function()
        real_metamethods.__eq = debug.info(2, "f")
    end)

    xpcall(function()
        return tableorud + type_check_semibypass
    end, function()
        real_metamethods.__add = debug.info(2, "f")
    end)

    xpcall(function()
        return tableorud - type_check_semibypass
    end, function()
        real_metamethods.__sub = debug.info(2, "f")
    end)

    xpcall(function()
        return tableorud * type_check_semibypass
    end, function()
        real_metamethods.__mul = debug.info(2, "f")
    end)

    xpcall(function()
        return tableorud / type_check_semibypass
    end, function()
        real_metamethods.__div = debug.info(2, "f")
    end)

    xpcall(function() -- * LUAU
        return tableorud // type_check_semibypass
    end, function()
        real_metamethods.__idiv = debug.info(2, "f")
    end)

    xpcall(function()
        return tableorud % type_check_semibypass
    end, function()
        real_metamethods.__mod = debug.info(2, "f")
    end)

    xpcall(function()
        return tableorud ^ type_check_semibypass
    end, function()
        real_metamethods.__pow = debug.info(2, "f")
    end)

    xpcall(function()
        return -tableorud
    end, function()
        real_metamethods.__unm = debug.info(2, "f")
    end)

    xpcall(function()
        return tableorud < type_check_semibypass
    end, function()
        real_metamethods.__lt = debug.info(2, "f")
    end)

    xpcall(function()
        return tableorud <= type_check_semibypass
    end, function()
        real_metamethods.__le = debug.info(2, "f")
    end)

    xpcall(function()
        return tableorud .. type_check_semibypass
    end, function()
        real_metamethods.__concat = debug.info(2, "f")
    end)
    real_metamethods.__type = typeof(tableorud)

    real_metamethods.__metatable = getmetatable(game) -- "The metatable is locked"

    real_metamethods.__tostring = function()
        return tostring(tableorud)
    end

    return real_metamethods
end
