function debug.getmetatable(tableorud)
    local result = getmetatable(tableorud)

    if result == nil then -- No meta
        return
    end

    if type(result) == "table" and pcall(setmetatable, tableorud, result) then -- This checks if it's real without overwriting
        return result --* We dont cache this as it will be the same always anyways
    end
    -- Metamethod bruteforcing
    -- For Full (except __gc & __tostring) Metamethod list Refer to - https://github.com/luau-lang/luau/blob/master/VM/src/ltm.cpp#L34

    -- Todo: Look into more ways of making metamethods error (like https://github.com/luau-lang/luau/blob/master/VM%2Fsrc%2Flvmutils.cpp#L174)

    --TODO We can also rebuild many non-dynamic things like len or arithmetic  metamethods since we know what arguments to expect in those usually

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

    -- xpcall(function()
    -- -- !MAKE __mode ERROR SOMEHOW..
    -- end, function()
    -- 	newTable.__mode = debug.info(2, "f")
    -- end)

    xpcall(function()
        return tableorud:___() -- Make sure this doesn't exist in the tableorud
    end, function()
        real_metamethods.__namecall = debug.info(2, "f")
    end)

    xpcall(function()
        tableorud() -- ! This might not error on tables with __call defined
    end, function()
        real_metamethods.__call = debug.info(2, "f")
    end)

    xpcall(function() -- * LUAU
        for _ in tableorud do -- ! This will never error on tables
        end
    end, function()
        real_metamethods.__iter = debug.info(2, "f")
    end)

    xpcall(function()
        return #tableorud -- ! This will never error on tables, with userdata the issue is same as __concat - is it even a defined metamethod in that case?
    end, function()
        real_metamethods.__len = debug.info(2, "f")
    end)

    -- * Make sure type_check_semibypass lacks any metamethods
    local type_check_semibypass = {} -- bypass typechecks (which will return error instead of actual metamethod)

    xpcall(function()
        return tableorud == type_check_semibypass -- ! This will never error (it calls __eq but we need it to error); ~= can also be used
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
        return tableorud .. type_check_semibypass -- TODO Not sure if this would work on userdata.. (do they even have __concat defined? would it be called?)
    end, function()
        real_metamethods.__concat = debug.info(2, "f")
    end)

    -- xpcall(function()
    -- -- !MAKE __type ERROR SOMEHOW..
    -- end, function()
    -- 	newTable.__type = debug.info(2, "f")
    -- end)
    -- FAKE __type INBOUND
    real_metamethods.__type = typeof(tableorud)

    real_metamethods.__metatable = getmetatable(game) -- "The metatable is locked"

    -- xpcall(function()
    -- -- !MAKE __tostring  ERROR SOMEHOW..
    -- end, function()
    -- 	newTable.__tostring = debug.info(2, "f")
    -- end)

    -- FAKE __tostring INBOUND (We wrap it because 1. No rawtostring & 2. In case tableorud Name changes)
    real_metamethods.__tostring = function()
        return tostring(tableorud)
    end

    -- xpcall(function()
    -- -- !MAKE __gc ERROR SOMEHOW..
    -- end, function()
    -- 	newTable.__gc = debug.info(2, "f")
    -- end)

    -- table.freeze(real_metamethods) -- Not using for compatibility -- We can't check readonly state of an actual metatable sadly (or can we?)
    return real_metamethods
end