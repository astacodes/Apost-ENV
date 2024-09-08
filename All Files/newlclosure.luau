function newlclosure(func)
	return function(...)
		return func(...)
	end
end