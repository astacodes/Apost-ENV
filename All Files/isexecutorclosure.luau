function isexecutorclosure(func)
	for _, genv in getgenv() do
		if genv == func then
			return true
		end
	end
	local function check(t)
		local isglobal = false
		for i, v in t do
			if type(v) == "table" then
				check(v)
			end
			if v == func then
				isglobal = true
			end
		end
		return isglobal
	end
	if check(getgenv().getrenv()) then
		return false
	end
	return true
end

function checkclosure(func)
    return isexecutorclosure(func)
end

function isourclosure(func)
    return isexecutorclosure(func)
end