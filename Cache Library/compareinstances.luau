function compareinstances(x, y)
	if type(getmetatable(y)) == "table" then
		return x.ClassName == y.ClassName
	end
	return false
end