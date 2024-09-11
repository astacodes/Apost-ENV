function debug.getstack(l, i)
    local s = {}
    local j = 1
    while true do
        local n, v = debug.getlocal(l + 1, j)
        if not n then break end
        s[j] = v
        j = j + 1
    end
    return i and s[i] or s
end

--[[ Optional - Another GetStack Method - Credit to Ignite
function debug.getstack(level)
	if type(level) ~= "number" or level < 1 then
	    error("Invalid level. Must be a positive number.")
	end

	local stackInfo = {}

	for i = 1, level do
		local info = debug.getinfo(i, "snl")
		if info then
		table.insert(stackInfo, {
			source = (info.source == "[C]" and "@[C]") or info.source,
		short_src = info.short_src,
			currentline = info.currentline,
			name = info.name,
			what = info.what,
			numparams = info.nparams,
			is_vararg = info.isvararg
		})
		else
			break
		end
	end
	
	return stackInfo
end
--]]
