function islclosure(func)
	local success = pcall(function()
		return setfenv(func, getfenv(func))
	end)
	return success
end