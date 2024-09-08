function getscriptclosure(s)
	return function()
		return table.clone(require(s))
	end
end

function getscriptfunction(s)
	return getscriptclosure(s)
end

function get(s)
	return getscriptclosure(s)
end