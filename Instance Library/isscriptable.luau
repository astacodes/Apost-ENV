function isscriptable(object, property)
	if object and typeof(object) == 'Instance' then
		local success, result = pcall(function()
			return object[property] ~= nil
		end)
		return success and result
	end
	return false
end